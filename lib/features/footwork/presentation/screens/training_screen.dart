import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../domain/enums/direction.dart';
import '../../domain/enums/shot_type.dart';
import '../widgets/direction_flow_pad.dart';
import '../widgets/training_controls.dart';
import '../widgets/training_header.dart';
import '../widgets/training_settings_panel.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({
    required this.selectedCorners,
    required this.sets,
    required this.shotsPerSet,
    required this.speed,
    required this.restSeconds,
    required this.useRingtone,
    this.selectedShots = const {},
    super.key,
  });

  final Set<int> selectedCorners;
  final Set<ShotType> selectedShots;
  final int sets;
  final int shotsPerSet;
  final double speed;
  final int restSeconds;
  final bool useRingtone;

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final Random _random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  Timer? _timer;
  Timer? _returnToCenterTimer;
  Timer? _startCountdownTimer;
  bool _isStarting = false;
  bool _isResting = false;
  bool _isPaused = false;
  bool _pulseIn = false;

  int _startCountdown = 0;

  late final int _totalShots;
  int _currentShot = 0;

  late String _currentShotName;
  int _currentCorner = 0;
  late double _speed;
  late bool _useRingtone;

  String _shotClear() => context.l10n.shotClear;
  String _shotDrop() => context.l10n.shotDrop;
  String _shotSmash() => context.l10n.shotSmash;
  String _shotLift() => context.l10n.shotLift;
  String _shotBlock() => context.l10n.shotBlock;
  String _shotKill() => context.l10n.shotKill;
  String _shotDrive() => context.l10n.shotDrive;

  @override
  void initState() {
    super.initState();
    _totalShots = widget.sets * widget.shotsPerSet;
    _currentShotName = '';
    _speed = widget.speed;

    // Ringtone or Speech
    _useRingtone = widget.useRingtone;
    unawaited(_audioPlayer.setReleaseMode(ReleaseMode.stop));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _startTrainingFlow();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).toLanguageTag();
    unawaited(_tts.setLanguage(locale));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _returnToCenterTimer?.cancel();
    _startCountdownTimer?.cancel();
    unawaited(_audioPlayer.dispose());
    unawaited(_tts.stop());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completed = _currentShot >= _totalShots && _totalShots > 0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TrainingHeader(
                shotsText:
                    '${context.l10n.shotsLabel}: $_currentShot/$_totalShots',
                exitTooltip: context.l10n.exitLabel,
                onExit: () => Navigator.of(context).pop(),
              ),
              Expanded(
                // Completed
                child: completed
                    ? Center(
                        child: Text(
                          context.l10n.trainingCompletedLabel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    // Starting
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            if (_isStarting) ...[
                              Text(
                                context.l10n.trainingStartingSoon,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 8),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 220),
                                child: Text(
                                  '$_startCountdown',
                                  key: ValueKey(_startCountdown),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                              ),
                            ] else ...[
                              DirectionFlowPad(
                                activeCue: _cueForCorner(_currentCorner),
                                currentShot: _currentShot,
                                pulseIn: _pulseIn,
                              ),
                              AnimatedScale(
                                scale: _pulseIn ? 1.08 : 0.96,
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOut,
                                child: AnimatedOpacity(
                                  opacity: _pulseIn ? 1.0 : 0.95,
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOut,
                                  child: Text(
                                    _currentShotName.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
              TrainingSettingsPanel(
                speed: _speed,
                speedLabel: context.l10n.speedValue(_speed.toStringAsFixed(1)),
                ringtoneLabel: context.l10n.ringtone,
                speechLabel: context.l10n.speech,
                useRingtone: _useRingtone,
                onSpeedChanged: (v) {
                  setState(() => _speed = v);
                  _restartTimer();
                },
                onRingtoneSelected: () => setState(() => _useRingtone = true),
                onSpeechSelected: () => setState(() => _useRingtone = false),
              ),
              const SizedBox(height: 20),
              TrainingControls(
                isPaused: _isPaused,
                pauseTooltip: context.l10n.pauseLabel,
                resumeTooltip: context.l10n.resumeLabel,
                againTooltip: context.l10n.againLabel,
                onPauseToggle: _onPausePressed,
                onAgain: _onAgainPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTrainingFlow() {
    _timer?.cancel();
    _returnToCenterTimer?.cancel();
    _startCountdownTimer?.cancel();
    _isPaused = false;
    _isStarting = true;
    _startCountdown = 3;
    _currentCorner = 5;
    _currentShotName = '';
    setState(() {});

    _startCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_isPaused || _isResting) return;
      if (_startCountdown <= 1) {
        timer.cancel();
        _isStarting = false;
        _startCountdown = 0;
        _emitNextMove();
        _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
          if (_isPaused || _isResting || _isStarting) return;
          _emitNextMove();
        });
        setState(() {});
        return;
      }
      setState(() {
        _startCountdown -= 1;
      });
    });
  }

  Future<void> _emitNextMove() async {
    _returnToCenterTimer?.cancel();

    if (!_isResting &&
        _currentShot > 0 &&
        _currentShot % widget.shotsPerSet == 0 &&
        _currentShot < _totalShots) {
      _timer?.cancel();
      await _showRestDialog();
      if (!mounted || _isPaused) return;
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted || _isPaused) return;
      _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
        if (_isPaused || _isResting || _isStarting) return;
        _emitNextMove();
      });
    }

    if (_currentShot >= _totalShots) {
      _timer?.cancel();
      return;
    }
    final corner = _pickCorner();
    setState(() {
      _currentCorner = corner;
      _currentShot += 1;
      _currentShotName = _pickShotNameForCorner(corner);
      _pulseIn = !_pulseIn;
    });
    unawaited(_playMoveNotification());

    final strikeDuration = _strikeDurationFromSpeed(_speed);
    _returnToCenterTimer = Timer(strikeDuration, () {
      if (!mounted || _isPaused || _isResting) return;
      setState(() {
        // Recovery only: center is never counted as a strike.
        _currentCorner = 5;
      });
    });
  }

  int _pickCorner() {
    // Center (5) is a recovery point, not a strike target.
    final corners = widget.selectedCorners.where((c) => c != 5).toList();
    if (corners.isEmpty) return 2;
    return corners[_random.nextInt(corners.length)];
  }

  String _pickShotNameForCorner(int corner) {
    final zoneAllowed = ShotType.zoneAllowed(corner);
    final candidates = widget.selectedShots.isEmpty
        ? zoneAllowed
        : zoneAllowed.intersection(widget.selectedShots);
    final pool = (candidates.isEmpty ? zoneAllowed : candidates).toList();
    return _localizedShotName(pool[_random.nextInt(pool.length)]);
  }

  String _localizedShotName(ShotType shot) => switch (shot) {
    ShotType.clear => _shotClear(),
    ShotType.drop => _shotDrop(),
    ShotType.smash => _shotSmash(),
    ShotType.lift => _shotLift(),
    ShotType.block => _shotBlock(),
    ShotType.kill => _shotKill(),
    ShotType.drive => _shotDrive(),
  };

  //
  // Returns the interval between moves in milliseconds.
  //
  Duration _intervalFromSpeed(double speed) {
    final normalized = ((speed - 1.0) / 4.0).clamp(0.0, 1.0);
    final ms = (2500 - (normalized * 1900)).round();
    return Duration(milliseconds: ms);
  }

  //
  // Returns the duration of the strike cue in milliseconds.
  //
  Duration _strikeDurationFromSpeed(double speed) {
    final intervalMs = _intervalFromSpeed(speed).inMilliseconds;
    // Keep ~35% of each interval for strike cue, rest for return-to-center.
    final strikeMs = (intervalMs * 0.35).round().clamp(250, intervalMs - 120);
    return Duration(milliseconds: strikeMs);
  }

  Future<void> _playMoveNotification() async {
    if (_isPaused || _isResting) return;
    if (_useRingtone) {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/shuttles_hit.mp3'));
    } else {
      await _tts.stop();
      await _tts.speak(_currentShotName);
    }
  }

  void _onPausePressed() {
    setState(() => _isPaused = !_isPaused);
  }

  void _onAgainPressed() {
    setState(() {
      _currentShot = 0;
      _currentShotName = '';
      _currentCorner = 0;
    });
    _startTrainingFlow();
  }

  void _restartTimer() {
    _timer?.cancel();
    if (_isPaused || _isStarting) return;
    _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
      if (_isPaused || _isResting || _isStarting) return;
      _emitNextMove();
    });
  }

  DirectionCue _cueForCorner(int corner) => switch (corner) {
    1 => DirectionCue.upLeft,
    2 => DirectionCue.up,
    3 => DirectionCue.upRight,
    4 => DirectionCue.left,
    5 => DirectionCue.center,
    6 => DirectionCue.right,
    7 => DirectionCue.downLeft,
    8 => DirectionCue.down,
    9 => DirectionCue.downRight,
    _ => DirectionCue.none,
  };

  Future<void> _showRestDialog() async {
    if (!mounted) return;
    _isResting = true;

    var remaining = widget.restSeconds;
    Timer? countdown;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            countdown ??= Timer.periodic(const Duration(seconds: 1), (timer) {
              remaining -= 1;
              if (remaining <= 0) {
                timer.cancel();
                if (Navigator.of(ctx).canPop()) {
                  Navigator.of(ctx).pop();
                }
              } else {
                setDialogState(() {});
              }
            });

            return AlertDialog(
              title: Text(context.l10n.restBetweenSets),
              content: Text(
                context.l10n.restValue(remaining),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(context.l10n.skipLabel),
                ),
              ],
            );
          },
        );
      },
    );

    countdown?.cancel();
    _isResting = false;
  }
}

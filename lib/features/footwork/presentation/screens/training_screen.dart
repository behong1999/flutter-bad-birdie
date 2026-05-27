import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/direction.dart';
import '../widgets/direction_flow_pad.dart';
import '../widgets/training_controls.dart';
import '../widgets/training_header.dart';
import '../widgets/training_settings_panel.dart';

AppLocalizations loc(BuildContext context) => AppLocalizations.of(context)!;

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({
    super.key,
    required this.selectedCorners,
    required this.sets,
    required this.shotsPerSet,
    required this.speed,
    required this.restSeconds,
    required this.useRingtone,
  });

  final Set<int> selectedCorners;
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
  Timer? _timer;
  Timer? _returnToCenterTimer;
  Timer? _startCountdownTimer;
  bool _isStarted = false;
  bool _isStarting = false;
  bool _isResting = false;
  bool _isPaused = false;
  bool _isStopped = false;
  bool _pulseIn = false;

  int _startCountdown = 0;

  late final int _totalShots;
  int _currentShot = 0;

  late String _currentShotName;
  int _currentCorner = 0;
  late double _speed;
  late bool _useRingtone;

  String _shotClear() => loc(context).shotClear;
  String _shotDrop() => loc(context).shotDrop;
  String _shotSmash() => loc(context).shotSmash;
  String _shotLift() => loc(context).shotLift;
  String _shotBlock() => loc(context).shotBlock;
  String _shotKill() => loc(context).shotKill;
  String _shotDrive() => loc(context).shotDrive;

  @override
  void initState() {
    super.initState();
    _totalShots = widget.sets * widget.shotsPerSet;
    _currentShotName = '';
    _speed = widget.speed;
    _useRingtone = widget.useRingtone;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isStarted) return;
    _isStarted = true;
    _startTrainingFlow();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _returnToCenterTimer?.cancel();
    _startCountdownTimer?.cancel();
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
                shotsText: '${loc(context).shotsLabel}: $_currentShot/$_totalShots',
                exitTooltip: loc(context).exitLabel,
                onExit: () => Navigator.of(context).pop(),
              ),
              Expanded(
                // Completed
                child: completed
                    ? Center(
                        child: Text(
                          loc(context).trainingCompletedLabel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    // Stopped
                    : _isStopped
                    ? Center(
                        child: Text(
                          loc(context).trainingStoppedLabel,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    // Starting
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            if (_isStarting) ...[
                              Text(
                                loc(context).trainingStartingSoon,
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
                                        .displayMedium
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
                speedLabel: loc(context).speedValue(_speed.toStringAsFixed(1)),
                ringtoneLabel: loc(context).ringtone,
                speechLabel: loc(context).speech,
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
                stopTooltip: loc(context).stopLabel,
                pauseTooltip: loc(context).pauseLabel,
                resumeTooltip: loc(context).resumeLabel,
                againTooltip: loc(context).againLabel,
                onStop: _onStopPressed,
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
    _isStopped = false;
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
      if (_isPaused || _isStopped || _isResting) return;
      if (_startCountdown <= 1) {
        timer.cancel();
        _isStarting = false;
        _startCountdown = 0;
        _emitNextMove();
        _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
          if (_isPaused || _isStopped || _isResting || _isStarting) return;
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
      if (!mounted || _isPaused || _isStopped) return;
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted || _isPaused || _isStopped) return;
      _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
        if (_isPaused || _isStopped || _isResting || _isStarting) return;
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

    final strikeDuration = _strikeDurationFromSpeed(_speed);
    _returnToCenterTimer = Timer(strikeDuration, () {
      if (!mounted || _isPaused || _isStopped || _isResting) return;
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
    final frontCourt = [_shotLift(), _shotBlock(), _shotKill()];
    final backCourt = [_shotClear(), _shotDrop(), _shotSmash()];
    final midCourt = [_shotBlock(), _shotKill(), _shotDrive()];
    final shots = switch (corner) {
      1 || 2 || 3 => frontCourt,
      4 || 5 || 6 => midCourt,
      7 || 8 || 9 => backCourt,
      _ => frontCourt,
    };
    return shots[_random.nextInt(shots.length)];
  }

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

  void _onStopPressed() {
    setState(() => _isStopped = true);
    _timer?.cancel();
    _returnToCenterTimer?.cancel();
    _startCountdownTimer?.cancel();
    _isStarting = false;
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
    if (_isPaused || _isStopped || _isStarting) return;
    _timer = Timer.periodic(_intervalFromSpeed(_speed), (_) {
      if (_isPaused || _isStopped || _isResting || _isStarting) return;
      _emitNextMove();
    });
  }


  DirectionCue _cueForCorner(int corner) {
    switch (corner) {
      case 1:
        return DirectionCue.upLeft;
      case 2:
        return DirectionCue.up;
      case 3:
        return DirectionCue.upRight;
      case 4:
        return DirectionCue.left;
      case 5:
        return DirectionCue.center;
      case 6:
        return DirectionCue.right;
      case 7:
        return DirectionCue.downLeft;
      case 8:
        return DirectionCue.down;
      case 9:
        return DirectionCue.downRight;
      default:
        return DirectionCue.none;
    }
  }

  Future<void> _showRestDialog() async {
    if (!mounted) return;
    _isResting = true;

    int remaining = widget.restSeconds;
    Timer? countdown;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
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
              title: Text(loc(context).restBetweenSets),
              content: Text(
                loc(context).restValue(remaining),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(loc(context).skipLabel),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../data/preset_repository.dart';
import '../../domain/enums/shot_type.dart';
import '../../domain/training_preset.dart';
import '../widgets/preset_list_sheet.dart';
import '../widgets/save_preset_dialog.dart';
import 'training_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final Set<int> selectedCorners = {};
  final Set<ShotType> selectedShots = {};
  double sets = 3;
  double shots = 10;
  double speed = 2.5;
  double rest = 30;
  bool useRingtone = true;

  final PresetRepository _repository = PresetRepository();
  final Uuid _uuid = const Uuid();
  List<TrainingPreset> _presets = [];

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final presets = await _repository.loadPresets();
    final lastUsed = await _repository.loadLastUsed();
    if (!mounted) return;
    setState(() {
      _presets = presets;
      if (lastUsed != null) _applyPresetValues(lastUsed);
    });
  }

  void _applyPresetValues(TrainingPreset preset) {
    selectedCorners
      ..clear()
      ..addAll(preset.selectedCorners);
    selectedShots
      ..clear()
      ..addAll(preset.selectedShots);
    sets = preset.sets.toDouble();
    shots = preset.shotsPerSet.toDouble();
    speed = preset.speed.clamp(1.0, 4.0);
    rest = preset.restSeconds.toDouble();
    useRingtone = preset.useRingtone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.footworkTraining),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: context.l10n.loadPreset,
            onPressed: _openPresetList,
          ),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            tooltip: context.l10n.savePreset,
            onPressed: _openSaveDialog,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            context.l10n.chooseCornersTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.chooseCornersDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Center(child: _court()),
          if (selectedCorners.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              context.l10n.selectedCorners(
                selectedCorners.length,
                selectedCorners.join(', '),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  context.l10n.trainingSettings,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: context.l10n.help,
                  onPressed: _showHelp,
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.3,
              children: [
                _CircularStat(
                  label: context.l10n.sets,
                  valueLabel: '${sets.round()}',
                  value: sets,
                  min: 1,
                  max: 10,
                  onChanged: (v) => setState(() => sets = v.roundToDouble()),
                ),
                _CircularStat(
                  label: context.l10n.shotsPerSet,
                  valueLabel: '${shots.round()}',
                  value: shots,
                  min: 5,
                  max: 50,
                  onChanged: (v) => setState(() => shots = v.roundToDouble()),
                ),
                _CircularStat(
                  label: context.l10n.speed,
                  valueLabel: 'x${speed.toStringAsFixed(1)}',
                  value: speed,
                  min: 1,
                  max: 4,
                  onChanged: (v) =>
                      setState(() => speed = (v * 10).round() / 10),
                ),
                _CircularStat(
                  label: context.l10n.restBetweenSets,
                  valueLabel: '${rest.round()}s',
                  value: rest,
                  min: 10,
                  max: 120,
                  onChanged: (v) => setState(() => rest = v.roundToDouble()),
                ),
              ],
            ),
            _shotSelectionSection(context),
            const SizedBox(height: 8),
            Text(
              context.l10n.nextMoveNotification,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _cornerChip(
                    Icons.notifications_outlined,
                    context.l10n.ringtone,
                    useRingtone,
                    () => setState(() => useRingtone = true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _cornerChip(
                    Icons.record_voice_over_outlined,
                    context.l10n.speech,
                    !useRingtone,
                    () => setState(() => useRingtone = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              onPressed: _onBeginTraining,
              child: Text(context.l10n.letsBegin),
            ),
          ],
        ],
      ),
    );
  }

  Widget _shotSelectionSection(BuildContext context) {
    final available = ShotType.availableForCorners(selectedCorners).toList();
    if (available.isEmpty) return const SizedBox.shrink();
    return Theme(
      // ExpansionTile shows a divider by default; remove its visual clutter.
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text.rich(
          TextSpan(
            style: Theme.of(context).textTheme.titleMedium,
            children: [
              TextSpan(
                text: context.l10n.shotSelection,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' (${context.l10n.optional})'),
            ],
          ),
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(top: 8, bottom: 8),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 5,
            children: available
                .map(
                  (shot) => FilterChip(
                    label: Text(_shotName(shot)),
                    selected: selectedShots.contains(shot),
                    showCheckmark: false,
                    onSelected: (sel) => setState(() {
                      if (sel) {
                        selectedShots.add(shot);
                      } else {
                        selectedShots.remove(shot);
                      }
                    }),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String _shotName(ShotType shot) => switch (shot) {
    ShotType.clear => context.l10n.shotClear,
    ShotType.drop => context.l10n.shotDrop,
    ShotType.smash => context.l10n.shotSmash,
    ShotType.lift => context.l10n.shotLift,
    ShotType.block => context.l10n.shotBlock,
    ShotType.kill => context.l10n.shotKill,
    ShotType.drive => context.l10n.shotDrive,
  };

  Widget _court() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 300,
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(color: cs.primary, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: cs.primary.withValues(alpha: 0.08),
      ),
      child: Stack(
        children: [
          Align(child: Container(width: 3, color: cs.outline)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _courtRow([
                  _corner(1, Icons.north_west, context.l10n.frontLeft),
                  _corner(2, Icons.north, context.l10n.frontCenter),
                  _corner(3, Icons.north_east, context.l10n.frontRight),
                ]),
                _courtRow([
                  _corner(4, Icons.west, context.l10n.midLeft),
                  _centerMarker(),
                  _corner(6, Icons.east, context.l10n.midRight),
                ]),
                _courtRow([
                  _corner(7, Icons.south_west, context.l10n.backLeft),
                  _corner(8, Icons.south, context.l10n.backCenter),
                  _corner(9, Icons.south_east, context.l10n.backRight),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _courtRow(List<Widget> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items,
    );
  }

  Widget _centerMarker() {
    final cs = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 28,
      backgroundColor: cs.secondary,
      child: Icon(Icons.person, color: cs.onSecondary, size: 24),
    );
  }

  Widget _corner(int n, IconData icon, String semanticsLabel) {
    final on = selectedCorners.contains(n);
    final cs = Theme.of(context).colorScheme;
    final fg = on ? cs.onPrimary : cs.primary;
    return Semantics(
      button: true,
      selected: on,
      label: semanticsLabel.replaceAll('\n', ' '),
      child: GestureDetector(
        onTap: () => setState(() {
          if (on) {
            selectedCorners.remove(n);
          } else {
            selectedCorners.add(n);
          }
        }),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: on ? cs.primary : cs.surface,
            shape: BoxShape.circle,
            border: Border.all(color: on ? cs.primary : cs.outline),
          ),
          child: Icon(icon, size: 26, color: fg),
        ),
      ),
    );
  }

  Widget _cornerChip(
    IconData icon,
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    final cs = Theme.of(context).colorScheme;
    final fg = selected ? cs.onPrimary : cs.onSurfaceVariant;
    return Material(
      color: selected ? cs.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? cs.primary : cs.outline),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: fg),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelp() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.trainingSettingsHelp),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _helpLine(ctx, context.l10n.sets, context.l10n.setsHelp),
              _helpLine(ctx, context.l10n.shotsPerSet, context.l10n.shotsHelp),
              _helpLine(ctx, context.l10n.speed, context.l10n.speedHelp),
              _helpLine(
                ctx,
                context.l10n.restBetweenSets,
                context.l10n.restHelp,
              ),
              _helpLine(
                ctx,
                context.l10n.shotSelection,
                context.l10n.shotSelectionHelp,
              ),
              _helpLine(
                ctx,
                context.l10n.nextMoveNotification,
                context.l10n.notificationHelp,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.gotIt),
          ),
        ],
      ),
    );
  }

  Widget _helpLine(BuildContext ctx, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            body,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  TrainingPreset _currentPreset({String? id, String? name}) => TrainingPreset(
    id: id ?? _uuid.v4(),
    name: name ?? '',
    selectedCorners: Set<int>.from(selectedCorners),
    selectedShots: Set<ShotType>.from(selectedShots),
    sets: sets.round(),
    shotsPerSet: shots.round(),
    speed: speed,
    restSeconds: rest.round(),
    useRingtone: useRingtone,
  );

  Future<void> _openSaveDialog() async {
    if (selectedCorners.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.selectCornersFirst)));
      return;
    }
    final suggested = context.l10n.defaultPresetName(_presets.length + 1);
    final name = await showDialog<String>(
      context: context,
      builder: (_) => SavePresetDialog(
        suggestedName: suggested,
        existingNames: _presets.map((p) => p.name).toList(),
      ),
    );
    if (name == null || !mounted) return;
    final preset = _currentPreset(name: name);
    await _repository.savePreset(preset);
    if (!mounted) return;
    setState(() => _presets = [..._presets, preset]);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.presetSaved(name))));
  }

  Future<void> _openPresetList() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => PresetListSheet(
        presets: _presets,
        onSelect: (p) {
          Navigator.of(ctx).pop();
          setState(() => _applyPresetValues(p));
        },
        onDelete: (p) async {
          await _repository.deletePreset(p.id);
          if (!mounted) return;
          setState(
            () => _presets = _presets.where((e) => e.id != p.id).toList(),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.presetDeleted(p.name))),
          );
        },
      ),
    );
  }

  void _onBeginTraining() {
    unawaited(_repository.saveLastUsed(_currentPreset(name: 'last_used')));
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (ctx) => TrainingScreen(
          selectedCorners: selectedCorners,
          selectedShots: selectedShots,
          sets: sets.round(),
          shotsPerSet: shots.round(),
          speed: speed,
          restSeconds: rest.round(),
          useRingtone: useRingtone,
        ),
      ),
    );
  }
}

class _CircularStat extends StatelessWidget {
  const _CircularStat({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final dim = constraints.biggest.shortestSide.clamp(110.0, 140.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            SleekCircularSlider(
              min: min,
              max: max,
              initialValue: value,
              onChange: onChanged,
              appearance: CircularSliderAppearance(
                size: dim,
                startAngle: 130,
                angleRange: 280,
                customWidths: CustomSliderWidths(
                  trackWidth: 6,
                  progressBarWidth: 10,
                  handlerSize: 8,
                ),
                customColors: CustomSliderColors(
                  trackColor: cs.surfaceContainerHighest,
                  progressBarColor: cs.primary,
                  dotColor: cs.onSurface,
                  hideShadow: true,
                ),
                infoProperties: InfoProperties(
                  topLabelText: '',
                  modifier: (_) => '',
                ),
              ),
            ),
            IgnorePointer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    valueLabel,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

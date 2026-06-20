import 'package:flutter/material.dart';
import '../../../../core/extensions/l10n_extension.dart';
import 'training_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final Set<int> selectedCorners = {};
  double sets = 3;
  double shots = 10;
  double speed = 2.5;
  double rest = 30;
  bool useRingtone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.footworkTraining),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: context.l10n.saveSettings,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.settingsSaved)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: context.l10n.help,
            onPressed: _showHelp,
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
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(
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
            Text(
              context.l10n.trainingSettings,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(context.l10n.setsValue(sets.round())),
            Slider(
              value: sets,
              min: 1,
              max: 10,
              divisions: 9,
              label: '${sets.round()}',
              onChanged: (v) => setState(() => sets = v),
            ),
            Text(context.l10n.shotsValue(shots.round())),
            Slider(
              value: shots,
              min: 5,
              max: 50,
              divisions: 45,
              label: '${shots.round()}',
              onChanged: (v) => setState(() => shots = v),
            ),
            Text(context.l10n.speedValue(speed.toStringAsFixed(1))),
            Slider(
              value: speed,
              min: 1,
              max: 5,
              divisions: 40,
              label: speed.toStringAsFixed(1),
              onChanged: (v) => setState(() => speed = v),
            ),
            Text(context.l10n.restValue(rest.round())),
            Slider(
              value: rest,
              min: 10,
              max: 120,
              divisions: 22,
              label: '${rest.round()}',
              onChanged: (v) => setState(() => rest = v),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.nextMoveNotification,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
          Align(
            alignment: Alignment.center,
            child: Container(width: 3, color: cs.outline),
          ),
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
            border: Border.all(
              color: selected ? cs.primary : cs.outline,
            ),
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
              _helpLine(ctx, context.l10n.restBetweenSets, context.l10n.restHelp),
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
          Text(body, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, height: 1.3)),
        ],
      ),
    );
  }

  void _onBeginTraining() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TrainingScreen(
          selectedCorners: selectedCorners,
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

import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'training_screen.dart';

AppLocalizations loc(BuildContext context) => AppLocalizations.of(context)!;

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
        title: Text(loc(context).footworkTraining),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: loc(context).saveSettings,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(loc(context).settingsSaved)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: loc(context).help,
            onPressed: _showHelp,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            loc(context).chooseCornersTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            loc(context).chooseCornersDescription,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Center(child: _court()),
          if (selectedCorners.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              loc(context).selectedCorners(
                selectedCorners.length,
                _cornerPluralSuffix(context, selectedCorners.length),
                selectedCorners.join(', '),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              loc(context).trainingSettings,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(loc(context).setsValue(sets.round())),
            Slider(
              value: sets,
              min: 1,
              max: 10,
              divisions: 9,
              label: '${sets.round()}',
              onChanged: (v) => setState(() => sets = v),
            ),
            Text(loc(context).shotsValue(shots.round())),
            Slider(
              value: shots,
              min: 5,
              max: 50,
              divisions: 45,
              label: '${shots.round()}',
              onChanged: (v) => setState(() => shots = v),
            ),
            Text(loc(context).speedValue(speed.toStringAsFixed(1))),
            Slider(
              value: speed,
              min: 1,
              max: 5,
              divisions: 40,
              label: speed.toStringAsFixed(1),
              onChanged: (v) => setState(() => speed = v),
            ),
            Text(loc(context).restValue(rest.round())),
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
              loc(context).nextMoveNotification,
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
                    loc(context).ringtone,
                    useRingtone,
                    () => setState(() => useRingtone = true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _cornerChip(
                    Icons.record_voice_over_outlined,
                    loc(context).speech,
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
              child: Text(loc(context).letsBegin),
            ),
          ],
        ],
      ),
    );
  }

  Widget _court() {
    return Container(
      width: 300,
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.green.withValues(alpha: 0.1),
      ),
      child: CustomPaint(
        painter: const _CourtCenterLinePainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _courtRow([
                _corner(1, Icons.north_west, loc(context).frontLeft),
                _corner(2, Icons.north, loc(context).frontCenter),
                _corner(3, Icons.north_east, loc(context).frontRight),
              ]),
              _courtRow([
                _corner(4, Icons.west, loc(context).midLeft),
                _centerMarker(),
                _corner(6, Icons.east, loc(context).midRight),
              ]),
              _courtRow([
                _corner(7, Icons.south_west, loc(context).backLeft),
                _corner(8, Icons.south, loc(context).backCenter),
                _corner(9, Icons.south_east, loc(context).backRight),
              ]),
            ],
          ),
        ),
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
    return const CircleAvatar(
      radius: 28,
      backgroundColor: Colors.orange,
      child: Icon(Icons.person, color: Colors.white, size: 24),
    );
  }

  Widget _corner(int n, IconData icon, String semanticsLabel) {
    final on = selectedCorners.contains(n);
    final primary = Theme.of(context).colorScheme.primary;
    final fg = on ? Colors.white : primary;
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
            color: on ? primary : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: on ? primary : Colors.grey),
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
    final fg = selected ? Colors.white : Colors.grey[700]!;
    return Material(
      color: selected
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
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
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
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
        title: Text(loc(ctx).trainingSettingsHelp),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _helpLine(ctx, loc(ctx).sets, loc(ctx).setsHelp),
              _helpLine(ctx, loc(ctx).shotsPerSet, loc(ctx).shotsHelp),
              _helpLine(ctx, loc(ctx).speed, loc(ctx).speedHelp),
              _helpLine(ctx, loc(ctx).restBetweenSets, loc(ctx).restHelp),
              _helpLine(
                ctx,
                loc(ctx).nextMoveNotification,
                loc(ctx).notificationHelp,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc(ctx).gotIt),
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
          Text(body, style: TextStyle(color: Colors.grey[700], height: 1.3)),
        ],
      ),
    );
  }

  /// English: corner→corners (`s`). German: Ecke→Ecken (`n`).
  String _cornerPluralSuffix(BuildContext context, int count) {
    if (count <= 1) return '';
    return Localizations.localeOf(context).languageCode == 'de' ? 'n' : 's';
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

class _CourtCenterLinePainter extends CustomPainter {
  const _CourtCenterLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final x = size.width / 2;
    canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _CourtCenterLinePainter oldDelegate) => false;
}

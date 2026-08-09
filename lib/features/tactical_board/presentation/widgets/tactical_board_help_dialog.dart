import 'package:flutter/material.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../domain/models/draw_tool.dart';

class TacticalBoardHelpDialog extends StatelessWidget {
  const TacticalBoardHelpDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const TacticalBoardHelpDialog(),
  );

  static List<String> bulletPoints(String text) {
    return text
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Center(child: Text(l10n.help)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HelpRow(
              icon: Icons.person_pin_circle_outlined,
              title: l10n.tacticalBoardHelpMarkersTitle,
              body: l10n.tacticalBoardHelpMarkers,
            ),
            _HelpRow(
              icon: DrawTool.pencil.icon,
              title: l10n.toolPencil,
              body: l10n.tacticalBoardHelpPencil,
            ),
            _HelpRow(
              icon: DrawTool.arrow.icon,
              title: l10n.toolArrow,
              body: l10n.tacticalBoardHelpArrow,
            ),
            _HelpRow(
              icon: Icons.palette_outlined,
              title: l10n.tacticalBoardHelpColorsTitle,
              body: l10n.tacticalBoardHelpColors,
            ),
            _HelpRow(
              icon: Icons.undo,
              title: l10n.undoLabel,
              body: l10n.tacticalBoardHelpUndo,
            ),
            _HelpRow(
              icon: Icons.delete_sweep_outlined,
              title: l10n.clearBoard,
              body: l10n.tacticalBoardHelpClear,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.gotIt),
        ),
      ],
    );
  }
}

class _HelpRow extends StatelessWidget {
  const _HelpRow({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final points = TacticalBoardHelpDialog.bulletPoints(body);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                _BulletList(
                  points: points,
                  style: TextStyle(color: cs.onSurfaceVariant, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.points, required this.style});

  final List<String> points;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (points.length == 1) {
      return Text(points.first, style: style);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final point in points)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2, right: 8),
                  child: Text('•', style: style),
                ),
                Expanded(child: Text(point, style: style)),
              ],
            ),
          ),
      ],
    );
  }
}

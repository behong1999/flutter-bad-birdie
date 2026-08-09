import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/draw_tool.dart';

class BoardToolbar extends StatelessWidget {
  const BoardToolbar({
    required this.activeTool,
    required this.activeColor,
    required this.canUndo,
    required this.strokeColors,
    required this.onToolSelected,
    required this.onColorSelected,
    required this.onUndo,
    required this.onClear,
    super.key,
  });

  final DrawTool activeTool;
  final Color activeColor;
  final bool canUndo;
  final List<Color> strokeColors;
  final ValueChanged<DrawTool> onToolSelected;
  final ValueChanged<Color> onColorSelected;
  final VoidCallback onUndo;
  final VoidCallback onClear;

  static const _buttonConstraints = BoxConstraints(minWidth: 40, minHeight: 40);
  static const _buttonPadding = EdgeInsets.zero;
  static const _iconSize = 20.0;

  String _toolTooltip(DrawTool tool, AppLocalizations l10n) => switch (tool) {
    DrawTool.pencil => l10n.toolPencil,
    DrawTool.arrow => l10n.toolArrow,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return ColoredBox(
      color: cs.surfaceContainerHighest,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              // Tool selection
              ...DrawTool.values.map((tool) {
                final active = tool == activeTool;
                return IconButton(
                  constraints: _buttonConstraints,
                  padding: _buttonPadding,
                  iconSize: _iconSize,
                  icon: Icon(tool.icon),
                  color: active ? cs.primary : cs.onSurfaceVariant,
                  style: active
                      ? IconButton.styleFrom(
                          backgroundColor: cs.primaryContainer,
                        )
                      : null,
                  tooltip: _toolTooltip(tool, l10n),
                  onPressed: () => onToolSelected(tool),
                );
              }),
              const SizedBox(width: 4),
              // Color palette
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: strokeColors.map((color) {
                    final active = color.toARGB32() == activeColor.toARGB32();
                    return GestureDetector(
                      onTap: () => onColorSelected(color),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 22 : 16,
                        height: active ? 22 : 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          border: active
                              ? Border.all(color: cs.primary, width: 2.5)
                              : Border.all(
                                  color: cs.outline.withValues(alpha: 0.4),
                                ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 4),
              // Undo + Clear
              IconButton(
                constraints: _buttonConstraints,
                padding: _buttonPadding,
                iconSize: _iconSize,
                icon: const Icon(Icons.undo),
                tooltip: l10n.undoLabel,
                onPressed: canUndo ? onUndo : null,
              ),
              IconButton(
                constraints: _buttonConstraints,
                padding: _buttonPadding,
                iconSize: _iconSize,
                icon: const Icon(Icons.delete_sweep_outlined),
                tooltip: l10n.clearBoard,
                onPressed: onClear,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../domain/training_preset.dart';

class PresetListSheet extends StatelessWidget {
  const PresetListSheet({
    required this.presets,
    required this.onSelect,
    required this.onDelete,
    super.key,
  });

  final List<TrainingPreset> presets;
  final ValueChanged<TrainingPreset> onSelect;
  final ValueChanged<TrainingPreset> onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                context.l10n.presets,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            if (presets.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  context.l10n.noPresetsYet,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: presets.length,
                  itemBuilder: (context, i) {
                    final p = presets[i];
                    final cs = Theme.of(context).colorScheme;
                    return Dismissible(
                      key: ValueKey(p.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: cs.errorContainer,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Icon(
                          Icons.delete_outline,
                          color: cs.onErrorContainer,
                        ),
                      ),
                      onDismissed: (_) => onDelete(p),
                      child: ListTile(
                        title: Text(p.name),
                        subtitle: Text(
                          context.l10n.presetSummary(
                            p.sets,
                            p.shotsPerSet,
                            p.speed.toStringAsFixed(1),
                            p.restSeconds,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: context.l10n.delete,
                          color: cs.error,
                          onPressed: () => onDelete(p),
                        ),
                        onTap: () => onSelect(p),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

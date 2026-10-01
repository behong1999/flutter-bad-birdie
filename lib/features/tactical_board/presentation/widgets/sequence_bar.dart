import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class SequenceBar extends StatefulWidget {
  const SequenceBar({
    required this.frameCount,
    required this.loadedFrameIndex,
    required this.isPlaying,
    required this.onAddStep,
    required this.onPlay,
    required this.onStop,
    required this.onSelectFrame,
    required this.onExit,
    super.key,
  });

  final int frameCount;
  final int? loadedFrameIndex;
  final bool isPlaying;
  final VoidCallback onAddStep;
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final ValueChanged<int> onSelectFrame;
  final VoidCallback onExit;

  @override
  State<SequenceBar> createState() => _SequenceBarState();
}

class _SequenceBarState extends State<SequenceBar> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(SequenceBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.frameCount > oldWidget.frameCount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Container(
      color: cs.surfaceContainerHigh,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          _PlayButton(
            isPlaying: widget.isPlaying,
            canPlay: widget.frameCount > 0,
            playLabel: l10n.playSequence,
            stopLabel: l10n.stopSequence,
            onPlay: widget.onPlay,
            onStop: widget.onStop,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: widget.frameCount == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      l10n.sequenceEmpty,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 2,
                    ),
                  )
                : SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 6,
                      children: List.generate(widget.frameCount, (i) {
                        final isActive = widget.loadedFrameIndex == i;
                        return _FrameChip(
                          label: l10n.stepLabel(i + 1),
                          isActive: isActive,
                          onTap: () => widget.onSelectFrame(i),
                        );
                      }),
                    ),
                  ),
          ),
          const SizedBox(width: 4),
          _AddStepButton(
            label: l10n.addStep,
            enabled: !widget.isPlaying,
            onTap: widget.onAddStep,
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            tooltip: l10n.exitLabel,
            onPressed: widget.isPlaying ? null : widget.onExit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.isPlaying,
    required this.canPlay,
    required this.playLabel,
    required this.stopLabel,
    required this.onPlay,
    required this.onStop,
  });

  final bool isPlaying;
  final bool canPlay;
  final String playLabel;
  final String stopLabel;
  final VoidCallback onPlay;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isPlaying ? Icons.stop_circle_outlined : Icons.play_circle_outline,
      ),
      tooltip: isPlaying ? stopLabel : playLabel,
      onPressed: canPlay ? (isPlaying ? onStop : onPlay) : null,
    );
  }
}

class _FrameChip extends StatelessWidget {
  const _FrameChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? cs.primaryContainer : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: isActive ? Border.all(color: cs.primary, width: 1.5) : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isActive ? cs.onPrimaryContainer : cs.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _AddStepButton extends StatelessWidget {
  const _AddStepButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextButton.icon(
      onPressed: enabled ? onTap : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        foregroundColor: cs.primary,
      ),
      icon: const Icon(Icons.add, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

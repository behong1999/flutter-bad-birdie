import 'package:flutter/material.dart';

import '../../../../core/layout/responsive_breakpoint.dart';

class TrainingHeader extends StatelessWidget {
  const TrainingHeader({
    required this.shotsText,
    required this.exitTooltip,
    required this.onExit,
    this.showFullscreenToggle = false,
    this.isFullscreen = false,
    this.enterFullscreenTooltip,
    this.exitFullscreenTooltip,
    this.onFullscreenToggle,
    super.key,
  });

  final String shotsText;
  final String exitTooltip;
  final VoidCallback onExit;
  final bool showFullscreenToggle;
  final bool isFullscreen;
  final String? enterFullscreenTooltip;
  final String? exitFullscreenTooltip;
  final VoidCallback? onFullscreenToggle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.responsiveValue(
      phone: Theme.of(context).textTheme.titleMedium,
      tablet: Theme.of(context).textTheme.titleLarge,
      desktop: Theme.of(context).textTheme.titleLarge,
    );

    return Row(
      children: [
        Flexible(
          child: Text(
            shotsText,
            style: titleStyle?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        if (showFullscreenToggle && onFullscreenToggle != null) ...[
          const SizedBox(width: 12),
          IconButton(
            iconSize: context.responsiveValue(
              phone: 28,
              tablet: 32,
              desktop: 32,
            ),
            onPressed: onFullscreenToggle,
            tooltip: isFullscreen
                ? exitFullscreenTooltip
                : enterFullscreenTooltip,
            icon: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
          ),
        ],
        IconButton(
          iconSize: context.responsiveValue(phone: 32, tablet: 36, desktop: 36),
          onPressed: onExit,
          tooltip: exitTooltip,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

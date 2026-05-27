import 'package:flutter/material.dart';

class TrainingControls extends StatelessWidget {
  const TrainingControls({
    super.key,
    required this.isPaused,
    required this.stopTooltip,
    required this.pauseTooltip,
    required this.resumeTooltip,
    required this.againTooltip,
    required this.onStop,
    required this.onPauseToggle,
    required this.onAgain,
  });

  final bool isPaused;
  final String stopTooltip;
  final String pauseTooltip;
  final String resumeTooltip;
  final String againTooltip;
  final VoidCallback onStop;
  final VoidCallback onPauseToggle;
  final VoidCallback onAgain;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: onStop,
          tooltip: stopTooltip,
          icon: const Icon(Icons.stop_circle_outlined),
        ),
        IconButton(
          iconSize: 40,
          onPressed: onPauseToggle,
          tooltip: isPaused ? resumeTooltip : pauseTooltip,
          icon: Icon(
            isPaused ? Icons.play_circle_outline : Icons.pause_circle_outline,
          ),
        ),
        IconButton(
          iconSize: 40,
          onPressed: onAgain,
          tooltip: againTooltip,
          icon: const Icon(Icons.replay_circle_filled_outlined),
        ),
      ],
    );
  }
}

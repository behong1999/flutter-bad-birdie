import 'package:flutter/material.dart';

class TrainingHeader extends StatelessWidget {
  const TrainingHeader({
    required this.shotsText,
    required this.exitTooltip,
    required this.onExit,
    super.key,
  });

  final String shotsText;
  final String exitTooltip;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          shotsText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        IconButton(
          iconSize: 40,
          onPressed: onExit,
          tooltip: exitTooltip,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

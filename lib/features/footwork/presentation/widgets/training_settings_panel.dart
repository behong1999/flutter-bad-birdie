import 'package:flutter/material.dart';

import 'indicator_chip.dart';

class TrainingSettingsPanel extends StatelessWidget {
  const TrainingSettingsPanel({
    super.key,
    required this.speed,
    required this.speedLabel,
    required this.ringtoneLabel,
    required this.speechLabel,
    required this.useRingtone,
    required this.onSpeedChanged,
    required this.onRingtoneSelected,
    required this.onSpeechSelected,
  });

  final double speed;
  final String speedLabel;
  final String ringtoneLabel;
  final String speechLabel;
  final bool useRingtone;
  final ValueChanged<double> onSpeedChanged;
  final VoidCallback onRingtoneSelected;
  final VoidCallback onSpeechSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.speed, size: 24, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              speedLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            Expanded(
              child: Slider(
                value: speed,
                min: 1,
                max: 5,
                divisions: 40,
                label: speed.toStringAsFixed(1),
                onChanged: onSpeedChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IndicatorChip(
              icon: Icons.notifications_outlined,
              label: ringtoneLabel,
              selected: useRingtone,
              onTap: onRingtoneSelected,
            ),
            const SizedBox(width: 12),
            IndicatorChip(
              icon: Icons.record_voice_over_outlined,
              label: speechLabel,
              selected: !useRingtone,
              onTap: onSpeechSelected,
            ),
          ],
        ),
      ],
    );
  }
}

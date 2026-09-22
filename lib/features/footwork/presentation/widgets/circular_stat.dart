import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

/// Circular slider for a single training setup value (sets, speed, etc.).
class CircularStat extends StatelessWidget {
  const CircularStat({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final dim = constraints.biggest.shortestSide.clamp(110.0, 160.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            SleekCircularSlider(
              min: min,
              max: max,
              initialValue: value,
              onChange: onChanged,
              appearance: CircularSliderAppearance(
                size: dim,
                startAngle: 130,
                angleRange: 280,
                customWidths: CustomSliderWidths(
                  trackWidth: 6,
                  progressBarWidth: 10,
                  handlerSize: 8,
                ),
                customColors: CustomSliderColors(
                  trackColor: cs.surfaceContainerHighest,
                  progressBarColor: cs.primary,
                  dotColor: cs.onSurface,
                  hideShadow: true,
                ),
                infoProperties: InfoProperties(
                  topLabelText: '',
                  modifier: (_) => '',
                ),
              ),
            ),
            IgnorePointer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    valueLabel,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

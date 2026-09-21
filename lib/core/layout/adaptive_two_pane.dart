import 'package:flutter/material.dart';

import 'responsive_breakpoint.dart';

/// Side-by-side on tablet/desktop; stacked on phone.
class AdaptiveTwoPane extends StatelessWidget {
  const AdaptiveTwoPane({
    required this.start,
    required this.end,
    this.spacing = 24,
    this.endPaneWidth = 340,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final Widget start;
  final Widget end;
  final double spacing;
  final double endPaneWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    if (context.isPhoneWidth) {
      return SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            start,
            SizedBox(height: spacing),
            end,
          ],
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: start),
          SizedBox(width: spacing),
          SizedBox(width: endPaneWidth, child: end),
        ],
      ),
    );
  }
}

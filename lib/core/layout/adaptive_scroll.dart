import 'package:flutter/material.dart';

import 'adaptive_two_pane.dart';
import 'responsive_breakpoint.dart';
import 'responsive_center.dart';

/// Standard screen body: picks layout from width without per-screen branching.
///
/// - [secondary] is null → centered single column on all sizes.
/// - [secondary] is set → stacked scroll on phone, side-by-side on tablet/desktop.
class AdaptiveScroll extends StatelessWidget {
  const AdaptiveScroll({
    required this.primary,
    this.secondary,
    this.maxWidth = 720,
    this.padding = const EdgeInsets.all(20),
    this.sectionSpacing = 16,
    this.endPaneWidth = 340,
    super.key,
  });

  final Widget primary;
  final Widget? secondary;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final double sectionSpacing;
  final double endPaneWidth;

  @override
  Widget build(BuildContext context) {
    if (secondary == null) {
      return ResponsiveCenter(
        maxWidth: maxWidth,
        child: ListView(padding: padding, children: [primary]),
      );
    }

    if (context.isTabletOrDesktop) {
      return AdaptiveTwoPane(
        padding: padding,
        endPaneWidth: endPaneWidth,
        start: primary,
        end: SingleChildScrollView(child: secondary),
      );
    }

    return ListView(
      padding: padding,
      children: [
        primary,
        SizedBox(height: sectionSpacing),
        secondary!,
      ],
    );
  }
}

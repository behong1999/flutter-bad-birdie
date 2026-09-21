import 'package:flutter/material.dart';

import 'responsive_breakpoint.dart';

/// Centers content and caps width on tablet/desktop with fluid horizontal padding.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    required this.child,
    this.maxWidth = 720,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.responsiveValue(
      phone: 16.0,
      tablet: 24.0,
      desktop: 32,
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.toDouble()),
          child: child,
        ),
      ),
    );
  }
}

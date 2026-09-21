import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Width breakpoints (not device detection):
/// phone < 600, tablet 600–900, desktop >= 900
abstract final class ResponsiveBreakpoints {
  static const phone = 600.0;
  static const tablet = 900.0;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  bool get isPhoneWidth => screenWidth < ResponsiveBreakpoints.phone;

  bool get isTabletWidth =>
      screenWidth >= ResponsiveBreakpoints.phone &&
      screenWidth < ResponsiveBreakpoints.tablet;

  bool get isDesktopWidth => screenWidth >= ResponsiveBreakpoints.tablet;

  bool get isTabletOrDesktop => screenWidth >= ResponsiveBreakpoints.phone;

  T responsiveValue<T>({
    required T phone,
    required T tablet,
    required T desktop,
  }) {
    if (isDesktopWidth) return desktop;
    if (isTabletWidth) return tablet;
    return phone;
  }

  /// Grid column count from breakpoint. Override per layout when needed.
  int responsiveColumns({
    int phone = 1,
    int tablet = 2,
    int desktop = 2,
  }) => responsiveValue(phone: phone, tablet: tablet, desktop: desktop);
}

/// Computes a fluid size from available space.
double fluidSize({
  required double maxWidth,
  required double maxHeight,
  required double widthFactor,
  required double min,
  required double max,
  double? heightFactor,
}) {
  final widthBased = maxWidth * widthFactor;
  if (heightFactor == null || !maxHeight.isFinite) {
    return widthBased.clamp(min, max);
  }
  final heightBased = maxHeight * heightFactor;
  return math.min(widthBased, heightBased).clamp(min, max);
}

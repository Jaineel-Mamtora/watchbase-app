import 'package:flutter/widgets.dart' show MediaQuery, BuildContext;

enum ResponsiveBreakpoint {
  base,
  sm,
  md,
  lg,
  xl,
  xxl,
}

class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  // Tailwind default breakpoints.
  static const double sm = 640;
  static const double md = 768;
  static const double lg = 1024;
  static const double xl = 1280;
  static const double x2l = 1536;

  static ResponsiveBreakpoint fromWidth(double width) {
    if (width < sm) {
      return ResponsiveBreakpoint.base;
    }
    if (width < md) {
      return ResponsiveBreakpoint.sm;
    }
    if (width < lg) {
      return ResponsiveBreakpoint.md;
    }
    if (width < xl) {
      return ResponsiveBreakpoint.lg;
    }
    if (width < x2l) {
      return ResponsiveBreakpoint.xl;
    }
    return ResponsiveBreakpoint.xxl;
  }

  static ResponsiveBreakpoint fromContext(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return fromWidth(width);
  }
}

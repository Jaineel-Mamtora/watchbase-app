import 'package:watchbase_app/core/utils/platform_info.dart';
import 'package:watchbase_app/core/utils/responsive_breakpoints.dart';

WebSectionLayout? resolveWebSectionLayout(double width) {
  if (!PlatformInfo.isWeb) {
    return null;
  }

  switch (ResponsiveBreakpoints.fromWidth(width)) {
    case ResponsiveBreakpoint.base:
      return const WebSectionLayout(
        posterWidth: 150,
        titleHorizontalPadding: 12,
        titleVerticalPadding: 8,
        listHorizontalPadding: 10,
        cardGap: 10,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.sm:
      return const WebSectionLayout(
        posterWidth: 170,
        titleHorizontalPadding: 14,
        titleVerticalPadding: 8,
        listHorizontalPadding: 12,
        cardGap: 12,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.md:
      return const WebSectionLayout(
        posterWidth: 190,
        titleHorizontalPadding: 16,
        titleVerticalPadding: 8,
        listHorizontalPadding: 14,
        cardGap: 12,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.lg:
      return const WebSectionLayout(
        posterWidth: 210,
        titleHorizontalPadding: 18,
        titleVerticalPadding: 10,
        listHorizontalPadding: 16,
        cardGap: 14,
        listHeightExtra: 16,
      );
    case ResponsiveBreakpoint.xl:
      return const WebSectionLayout(
        posterWidth: 230,
        titleHorizontalPadding: 24,
        titleVerticalPadding: 10,
        listHorizontalPadding: 20,
        cardGap: 16,
        listHeightExtra: 16,
      );
    case ResponsiveBreakpoint.xxl:
      return const WebSectionLayout(
        posterWidth: 250,
        titleHorizontalPadding: 28,
        titleVerticalPadding: 12,
        listHorizontalPadding: 24,
        cardGap: 18,
        listHeightExtra: 18,
      );
  }
}

class WebSectionLayout {
  const WebSectionLayout({
    required this.posterWidth,
    required this.titleHorizontalPadding,
    required this.titleVerticalPadding,
    required this.listHorizontalPadding,
    required this.cardGap,
    required this.listHeightExtra,
  });

  final double posterWidth;
  final double titleHorizontalPadding;
  final double titleVerticalPadding;
  final double listHorizontalPadding;
  final double cardGap;
  final double listHeightExtra;
}

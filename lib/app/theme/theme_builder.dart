import 'package:flutter/material.dart' show ColorScheme;

import 'package:dynamic_color/dynamic_color.dart';

import 'package:watchbase_app/app/theme/material_theme.dart';

class ThemeBuilder {
  /// Returns (lightScheme, darkScheme)
  static Future<(ColorScheme light, ColorScheme dark)>
  resolveColorSchemes() async {
    // If dynamic colors exist (Android 12+), use them.
    // Otherwise, fallback to Material 3 fromSeed with Colors.blueGrey
    final core = await DynamicColorPlugin.getCorePalette();

    if (core != null) {
      final light = core.toColorScheme();
      final dark = core.toColorScheme(brightness: .dark);
      return (light, dark);
    }

    return (
      WatchBaseMaterialTheme.fallbackLightScheme(),
      WatchBaseMaterialTheme.fallbackDarkScheme(),
    );
  }
}

import 'package:flutter/material.dart'
    show Color, Colors, ThemeData, ColorScheme;

class WatchBaseMaterialTheme {
  static const Color seed = Colors.blueGrey;

  static ThemeData light(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
    );
  }

  static ThemeData dark(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
    );
  }

  static ColorScheme fallbackLightScheme() => ColorScheme.fromSeed(
    seedColor: seed,
    brightness: .light,
  );

  static ColorScheme fallbackDarkScheme() => ColorScheme.fromSeed(
    seedColor: seed,
    brightness: .dark,
  );
}

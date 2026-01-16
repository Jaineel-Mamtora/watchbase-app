import 'package:flutter/cupertino.dart' show CupertinoThemeData;
import 'package:flutter/material.dart' show Color, Colors;

class WatchBaseCupertinoTheme {
  static const Color accent = Colors.blue;

  static CupertinoThemeData light() {
    return const CupertinoThemeData(
      brightness: .light,
      primaryColor: accent,
    );
  }

  static CupertinoThemeData dark() {
    return const CupertinoThemeData(
      brightness: .dark,
      primaryColor: accent,
    );
  }
}

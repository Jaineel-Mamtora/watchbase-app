import 'package:cupertino_ui/cupertino_ui.dart' show CupertinoThemeData;
import 'package:material_ui/material_ui.dart' show Color, Colors;

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

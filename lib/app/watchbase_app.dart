import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:watchbase_app/app/platform/platform_info.dart';
import 'package:watchbase_app/theme/cupertino_theme.dart';
import 'package:watchbase_app/theme/material_theme.dart';
import 'package:watchbase_app/theme/theme_builder.dart';

class WatchBaseApp extends StatefulWidget {
  const WatchBaseApp({super.key});

  @override
  State<WatchBaseApp> createState() => _WatchBaseAppState();
}

class _WatchBaseAppState extends State<WatchBaseApp> {
  late Future<(ColorScheme light, ColorScheme dark)> _schemes;

  @override
  void initState() {
    super.initState();
    _schemes = ThemeBuilder.resolveColorSchemes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _schemes,
      builder: (context, snapshot) {
        final schemes =
            snapshot.data ??
            (
              WatchBaseMaterialTheme.fallbackLightScheme(),
              WatchBaseMaterialTheme.fallbackDarkScheme(),
            );

        final materialLight = WatchBaseMaterialTheme.light(schemes.$1);
        final materialDark = WatchBaseMaterialTheme.dark(schemes.$2);

        // Single app shell, platform-adapted theming.
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WatchBase',
          themeMode: ThemeMode.system,
          theme: materialLight,
          darkTheme: materialDark,

          // On iOS, wrap the subtree with a CupertinoTheme so
          // Cupertino (and cupertino_native) widgets pick up defaults.
          builder: (context, child) {
            if (PlatformInfo.isIOS) {
              final brightness = MediaQuery.platformBrightnessOf(context);
              final cupertinoTheme = brightness == .light
                  ? WatchBaseCupertinoTheme.light()
                  : WatchBaseCupertinoTheme.dark();

              return CupertinoTheme(
                data: cupertinoTheme,
                child: child ?? const SizedBox.shrink(),
              );
            }

            return child ?? const SizedBox.shrink();
          },
          home: const _PlaceholderHome(),
        );
      },
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'WatchBase',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}

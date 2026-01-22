import 'package:flutter/material.dart' show immutable, Color;

@immutable
class AppTokens {
  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color divider;

  final Color textPrimary;
  final Color textSecondary;

  final Color accent;

  const AppTokens({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
  });
}

import 'package:flutter/material.dart';

ThemeData buildStudentFlowTheme() {
  final colours = ColorScheme.fromSeed(
    seedColor: const Color(0xFF006B5F),
    brightness: Brightness.light,
    contrastLevel: 0.5,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colours,
    scaffoldBackgroundColor: const Color(0xFFF7FAF9),
    cardTheme: const CardThemeData(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    visualDensity: VisualDensity.standard,
  );
}

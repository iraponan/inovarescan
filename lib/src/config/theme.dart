import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/custom_colors.dart';

mixin ThemeProject {
  static final theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: CustomColors.customSwathColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.customSwathColor,
          foregroundColor: Colors.white,
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/custom_colors.dart';

mixin ThemeProject {
  static final theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.customSwathColor,
          foregroundColor: Colors.white,
        ),
      ));
}

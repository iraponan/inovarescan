import 'package:flutter/material.dart';

mixin CustomColors {
  static final Map<int, Color> _swathOpacity = {
    50: const Color.fromRGBO(30, 58, 138, 0.1),
    100: const Color.fromRGBO(30, 58, 138, 0.2),
    200: const Color.fromRGBO(30, 58, 138, 0.3),
    300: const Color.fromRGBO(30, 58, 138, 0.4),
    400: const Color.fromRGBO(30, 58, 138, 0.5),
    500: const Color.fromRGBO(30, 58, 138, 0.6),
    600: const Color.fromRGBO(30, 58, 138, 0.7),
    700: const Color.fromRGBO(30, 58, 138, 0.8),
    800: const Color.fromRGBO(30, 58, 138, 0.9),
    900: const Color.fromRGBO(30, 58, 138, 1),
  };
  static MaterialColor customSwathColor = MaterialColor(0xFF1E3A8A, _swathOpacity);
  static Color customContrastColor = const Color.fromRGBO(59, 130, 246, 1);
  static Color customContrastColor2 = const Color.fromRGBO(0, 108, 84, 1);
}

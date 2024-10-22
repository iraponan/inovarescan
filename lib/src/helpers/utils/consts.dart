import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin VariablesUtils {
  static final double heightButton = 50;
  static final double heightIconPageEmpty = 75;
  static final Duration pageAnimationDuration = Duration(seconds: 1);
  static final List<String> dateOptions = ['Operação', 'Emissão'];
}

mixin StorageKeys {
  static final String token = dotenv.env['STORAGE_KEY'] ?? '';
}

enum NavigationTabs { home, movements, stock, profile }

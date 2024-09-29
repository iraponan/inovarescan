import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin VariablesUtils {
  static const double heightButton = 50;
  static const double heightIconPageEmpty = 75;
}

mixin StorageKeys {
  static final String token = dotenv.env['STORAGE_KEY'] ?? '';
}

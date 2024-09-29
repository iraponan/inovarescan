import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

mixin ConnectionCheck {
  static Future<bool> checkConnection() async {
    final statusConnection = await SimpleConnectionChecker.isConnectedToInternet(lookUpAddress: dotenv.env['SERVER_ADDRESS'] ?? '');
    if (statusConnection) {
      return true;
    } else {
      return false;
    }
  }
}

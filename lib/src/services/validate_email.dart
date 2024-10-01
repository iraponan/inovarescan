import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:inovarescan/src/helpers/utils/utils.dart';

mixin ValidateEmail {
  static Future<int> sendEmailValidator(String? email) async {
    final int numRandom = Utils.numRandom(100000, 999999);
    final Uri url = Uri.https(dotenv.env['URL_EMAIL_VALIDATOR'] ?? '', '${(dotenv.env['URL_PATH_EMAIL_VALIDATOR'] ?? '')}$email/${numRandom.toString()}');
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      return numRandom;
    } else {
      return 0;
    }
  }
}

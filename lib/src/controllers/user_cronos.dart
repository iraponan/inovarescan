import 'package:get/get.dart';
import 'package:inovarescan/src/repositories/mssql/users.dart';
import 'package:inovarescan/src/services/functions_for_cronos.dart';

class UserCronosController extends GetxController {
  final UsersCronosRepository _usersCronosRepository = UsersCronosRepository();

  Future<bool> validateUser(String user, String password) async {
    return await _usersCronosRepository.validateUser(user, FunctionsForCronos.encryptDecryptCronosPassword(password));
  }
}

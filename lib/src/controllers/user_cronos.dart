import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/repositories/mssql/users.dart';
import 'package:inovarescan/src/repositories/parse_server/auth.dart';
import 'package:inovarescan/src/services/functions_for_cronos.dart';

class UserCronosController extends GetxController {
  final _usersCronosRepository = UsersCronosRepository();
  final _authRepository = AuthRepository();

  bool userExists = false;

  Future<bool> validateUser(String user, String password) async {
    return await _usersCronosRepository.validateUser(user, FunctionsForCronos.encryptDecryptCronosPassword(password));
  }

  Future<void> validateUserExists(String user) async {
    final result = await _authRepository.validateUserCronosExists(user);

    result.when(
      success: (value) {
        userExists = value;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }
}

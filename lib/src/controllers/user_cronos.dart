import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/repositories/mssql/users.dart';
import 'package:inovarescan/src/repositories/parse_server/auth.dart';
import 'package:inovarescan/src/services/functions_for_cronos.dart';

class UserCronosController extends GetxController {
  final _usersCronosRepository = UsersCronosRepository();
  final _authRepository = AuthRepository();

  bool userExists = false;

  Future<bool> validateUser({required String user, required String password}) async {
    final result = await _usersCronosRepository.validateUserFromCronos(user: user, password: FunctionsForCronos.encryptDecryptCronosPassword(password));
    bool userValidate = false;
    result.when(
      success: (data) {
        userValidate = data;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
        userValidate = false;
      },
    );
    await _usersCronosRepository.disconnectMssql();
    return userValidate;
  }

  Future<void> validateUserExists({required String user}) async {
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

  Future<List<String>> getUserAccessCompanies({required String user}) async {
    final result = await _usersCronosRepository.getUserAccessCompaniesFromCronos(user: user);
    List<String> userAccessCompanies = [];
    result.when(
      success: (data) {
        for (var u in data) {
          userAccessCompanies.add(u[QueryUserAccessCompaniesColumnsNames.idCompany]);
        }
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
    await _usersCronosRepository.disconnectMssql();
    return userAccessCompanies;
  }
}

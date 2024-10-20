import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/user.dart';
import 'package:inovarescan/src/repositories/parse_server/auth.dart';
import 'package:inovarescan/src/results/auth.dart';
import 'package:inovarescan/src/results/reset_password.dart';
import 'package:inovarescan/src/services/storage_files.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUserValid = false.obs;

  final _authRepository = AuthRepository();

  User user = User();

  Future<void> getCurrentUser() async {
    String? token = await StorageFiles.getLocalData(key: StorageKeys.token);
    if (token == null || token.isEmpty) {
      Get.offAllNamed(PageRoutes.signInRoute);
      return;
    } else {
      AuthResult result = await _authRepository.currentUser(token: token);
      result.when(
        success: (user) {
          this.user = user;
          saveTokenAndProceedToBase();
        },
        error: (message) {
          signOut();
        },
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    AuthResult result = await _authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        if (user.active ?? false) {
          if (user.emailVerified ?? false) {
            saveTokenAndProceedToBase();
          } else {
            Utils.showToast(message: 'E-mail do Usuário não foi validado ainda.\nPor favor valide seu e-mail e tente novamente.', isInfo: true);
            signOut();
          }
        } else {
          Utils.showToast(message: 'Usuário não ativo.\nFale com o administrador da empresa para ativar seu usuário.', isInfo: true);
          signOut();
        }
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signOut() async {
    _authRepository.signOut(user: user);
    StorageFiles.removeLocalData(key: user.token ?? '');
    Get.offAllNamed(PageRoutes.signInRoute);
    user = User();
  }

  Future<bool> signUp() async {
    bool userSingUp = false;
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    AuthResult result = await _authRepository.signUp(user: user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        userSingUp = true;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
        userSingUp = false;
      },
    );
    return userSingUp;
  }

  Future<void> resetPassword(String email) async {
    ResetPasswordResult result = await _authRepository.resetPassword(email);
    FocusManager.instance.primaryFocus?.unfocus();
    result.when(
      success: (message) {
        Utils.showToast(message: message, isInfo: true);
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await _authRepository.changePassword(
      email: user.email ?? '',
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    isLoading.value = false;

    result.when(
      success: (value) {
        Utils.showToast(message: 'A senha foi atualizada com sucesso!', isInfo: true);
        signOut();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> updateEmailValidation(String email, bool value) async {
    final result = await _authRepository.updateEmailValidation(email: email, value: value);
    result.when(
      success: () {
        Utils.showToast(message: 'E-mail validado com sucesso.');
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  void saveTokenAndProceedToBase() async {
    await StorageFiles.saveLocalData(key: StorageKeys.token, data: user.token!);
    //await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(PageRoutes.baseRoute);
  }
}

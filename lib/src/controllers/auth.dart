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
        saveTokenAndProceedToBase();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> signOut() async {
    user = User();
    StorageFiles.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PageRoutes.signInRoute);
  }

  Future<void> signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    AuthResult result = await _authRepository.signUp(user: user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
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

  void saveTokenAndProceedToBase() {
    StorageFiles.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PageRoutes.baseRoute);
  }
}

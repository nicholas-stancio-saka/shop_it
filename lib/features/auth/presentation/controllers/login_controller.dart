// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';
import 'package:shop_it/features/auth/domain/usecases/login_user.dart';
import 'package:shop_it/features/auth/domain/usecases/register_user.dart';
import 'package:shop_it/features/auth/domain/usecases/reset_password.dart';

enum IntroPages { login, register, resetPassword }

class LoginController extends GetxController {
  // Use cases
  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final ResetPassword _resetPassword;

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  // Observables
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString rePassword = ''.obs;

  final currentPage = IntroPages.login.obs;
  final isPasswordHidden = true.obs;
  final errorMessage = Rxn<String>();

  // Constructor
  LoginController({
    required LoginUser loginUser,
    required RegisterUser registerUser,
    required ResetPassword resetPassword,
  })  : _loginUser = loginUser,
        _registerUser = registerUser,
        _resetPassword = resetPassword;

  // UI Navigation Methods
  void toLogin() {
    currentPage.value = IntroPages.login;
    cleanVariables();
  }

  void toCreateAccount() {
    currentPage.value = IntroPages.register;
    cleanVariables();
  }

  void toResetPassword() {
    currentPage.value = IntroPages.resetPassword;
    cleanVariables();
  }

  void toHomeScreen() {
    Get.offAllNamed('/home');
  }

  // Helper Method to clear inputs
  void cleanVariables() {
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    errorMessage.value = null;
  }

  // Main Auth Functions
  Future<void> login() async {
    AppGlobalLoader.showLoading();
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please provide both email and password.';
      AppGlobalLoader.hideLoading();
      return;
    }

    try {
      final user = await _loginUser.call(email, password);
      // Navigate to Home Screen on success
      toHomeScreen();
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred.';
    }
    AppGlobalLoader.hideLoading();
  }

  Future<void> register() async {
    AppGlobalLoader.showLoading();
    final email = emailController.text;
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (email.isEmpty || password.isEmpty || rePassword.isEmpty) {
      errorMessage.value = 'Please fill all the fields.';
      AppGlobalLoader.hideLoading();
      return;
    }

    if (password != rePassword) {
      errorMessage.value = 'Passwords do not match.';
      AppGlobalLoader.hideLoading();
      return;
    }

    try {
      final user = await _registerUser.call(email, password);
      // Navigate to Home Screen on success
      toHomeScreen();
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred.';
    }
    AppGlobalLoader.hideLoading();
  }

  Future<void> resetPassword() async {
    AppGlobalLoader.showLoading();
    final email = emailController.text;

    if (email.isEmpty) {
      errorMessage.value = 'Email field cannot be empty.';
      AppGlobalLoader.hideLoading();
      return;
    }

    try {
      await _resetPassword.call(email);
      // Show success dialog/message
      Get.snackbar('Success', 'Password reset email has been sent.');
      toLogin();
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred.';
    }
    AppGlobalLoader.hideLoading();
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize listeners
    emailController.addListener(() {
      email.value = emailController.text;
    });

    passwordController.addListener(() {
      password.value = passwordController.text;
    });

    rePasswordController.addListener(() {
      rePassword.value = rePasswordController.text;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }
}

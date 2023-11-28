import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/page.dart';
import 'package:shop_it/features/shared/widgets/text.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/auth/presentation/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Stack(
        children: [
          if (AppConfig.appType != AppType.release) _buildAutoFill(),
          _buildErrorMessage(),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 500,
                margin: const EdgeInsets.all(50),
                alignment: Alignment.center,
                child: Obx(() {
                  if (loginController.currentPage.value == IntroPages.register) {
                    return _buildRegisterScreen();
                  } else if (loginController.currentPage.value == IntroPages.resetPassword) {
                    return _buildResetPasswordScreen();
                  }

                  // Default
                  return _buildLoginScreen();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----- Main Screens -----
  Widget _buildLoginScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle('Log In'),
        Container(
          height: 20,
        ),
        _buildTextFields('Email', loginController.emailController, keyboardType: TextInputType.emailAddress),
        Container(
          height: 20,
        ),
        _buildPasswordTextFields('Password', loginController.passwordController, loginController.isPasswordHidden),
        Container(
          height: 20,
        ),
        Obx(
          () => _buildProceedButton(
            text: 'Log In',
            onTap: loginController.email.value == '' || loginController.password.value == ''
                ? null
                : () {
                    loginController.login();
                  },
          ),
        ),
        Container(
          height: 30,
        ),
        _buildToResetPassword(),
        Container(
          height: 20,
        ),
        if (AppConfig.appType != AppType.release) _buildToCreateAccount(),
      ],
    );
  }

  Widget _buildRegisterScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle('Register'),
        Container(
          height: 20,
        ),
        _buildTextFields('Email', loginController.emailController, keyboardType: TextInputType.emailAddress),
        Container(
          height: 20,
        ),
        _buildPasswordTextFields('Password', loginController.passwordController, loginController.isPasswordHidden),
        Container(
          height: 20,
        ),
        _buildPasswordTextFields('Re-enter Password', loginController.rePasswordController, loginController.isPasswordHidden),
        Container(
          height: 20,
        ),
        Obx(
          () => _buildProceedButton(
            text: 'Register',
            onTap: loginController.email.value == '' || loginController.password.value == '' || loginController.rePassword.value == ''
                ? null
                : () {
                    loginController.register();
                  },
          ),
        ),
        Container(
          height: 30,
        ),
        _buildToResetPassword(),
        Container(
          height: 20,
        ),
        _buildToLoginAccount(),
      ],
    );
  }

  Widget _buildResetPasswordScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle('Reset Password'),
        Container(
          height: 20,
        ),
        _buildTextFields('Email', loginController.emailController, keyboardType: TextInputType.emailAddress),
        Container(
          height: 20,
        ),
        Obx(
          () => _buildProceedButton(
            text: 'Reset',
            onTap: loginController.email.value == ''
                ? null
                : () {
                    loginController.resetPassword();
                  },
          ),
        ),
        Container(
          height: 30,
        ),
        _buildToLoginAccount(),
      ],
    );
  }

  // ----- Main Widgets -----
  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
      ),
    );
  }

  Widget _buildTextFields(String labelText, TextEditingController controller, {TextInputType? keyboardType}) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      keyboardType: keyboardType,
      enabledBorder: loginController.errorMessage.value == null
          ? null
          : OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.error),
            ),
    );
  }

  Widget _buildPasswordTextFields(String labelText, TextEditingController controller, RxBool isPasswordHiddenLogic) {
    return Obx(
      () => AppTextField(
        controller: controller,
        labelText: labelText,
        enabledBorder: loginController.errorMessage.value == null
            ? null
            : OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.error),
              ),
        obscureText: isPasswordHiddenLogic.value ? true : false,
        suffixIcon: GestureDetector(
          onTap: () {
            isPasswordHiddenLogic.value = !isPasswordHiddenLogic.value;
          },
          child: SizedBox.shrink(
            child: isPasswordHiddenLogic.value
                ? const Icon(
                    Icons.visibility_outlined,
                  )
                : const Icon(
                    Icons.visibility_off_outlined,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildProceedButton({required String text, void Function()? onTap}) {
    return SizedBox(
      width: 100,
      child: AppButton(
        onTap: onTap,
        child: Text(
          text,
        ),
      ),
    );
  }

  // ----- Page specific -----
  Widget _buildToResetPassword() {
    return GestureDetector(
      onTap: () {
        loginController.toResetPassword();
      },
      child: Text(
        'Reset Password',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          letterSpacing: 0.1,
          decoration: TextDecoration.underline,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildToCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            letterSpacing: 0.1,
          ),
        ),
        GestureDetector(
          onTap: () {
            loginController.toCreateAccount();
          },
          child: Text(
            'Create Account',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 0.1,
              decoration: TextDecoration.underline,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToLoginAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            letterSpacing: 0.1,
          ),
        ),
        GestureDetector(
          onTap: () {
            loginController.toLogin();
          },
          child: Text(
            'Sign in',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 0.1,
              decoration: TextDecoration.underline,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  // ----- Error handling -----
  Widget _buildErrorMessage() {
    return Positioned(
      bottom: 75,
      left: 0,
      right: 0,
      child: Obx(() {
        if (loginController.errorMessage.value != null) {
          return Text(
            loginController.errorMessage.value!,
            style: Theme.of(Get.context!).textTheme.titleMedium!.apply(
                  color: AppTheme.error,
                ),
            textAlign: TextAlign.center,
          );
        }

        return Container();
      }),
    );
  }

  // ----- Developer Related -----
  Widget _buildAutoFill() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: AppButton(
          onTap: () {
            loginController.emailController.text = 'tes@gmail.com';
            loginController.passwordController.text = '123456';
            loginController.rePasswordController.text = '123456';
          },
          child: const Text('Auto Fill'),
        ),
      ),
    );
  }
}

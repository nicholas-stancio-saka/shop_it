import 'package:shop_it/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthWidgets authWidgets;
  final AuthController authController;

  const LoginScreen(this.authWidgets, this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        authWidgets.buildTitle(),
        Container(
          height: 100,
        ),
        authWidgets.buildTextFields(
          'Username',
          authController.emailController,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.black54,
          ),
        ),
        Container(
          height: 20,
        ),
        authWidgets.buildPasswordTextFields(
          'Password',
          authController.passwordController,
          authController.isPasswordHidden,
        ),
        Container(
          height: 10,
        ),
        authWidgets.buildToResetPassword(),
        Container(
          height: 20,
        ),
        Obx(
          () => authWidgets.buildProceedButton(
            text: 'Sign In',
            onTap: authController.email.value == '' || authController.password.value == ''
                ? null
                : () {
                    authController.login();
                  },
          ),
        ),
        Container(
          height: 20,
        ),
        if (AppConfig.appType != AppType.release) _buildToCreateAccount(),
      ],
    );
  }

  // ----- Page specific -----
  Widget _buildToCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't have any account? ",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            letterSpacing: 0.1,
            color: Colors.black54,
          ),
        ),
        GestureDetector(
          onTap: () {
            authController.toCreateAccount();
          },
          child: Text(
            'Sign Up Here',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              letterSpacing: 0.1,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/auth/presentation/widgets/auth_widgets.dart';

class ResetPasswordScreen extends StatelessWidget {
  final AuthWidgets authWidgets;
  final AuthController authController;

  const ResetPasswordScreen(this.authWidgets, this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        authWidgets.buildTitle(),
        Container(
          height: 20,
        ),
        authWidgets.buildTextFields('Email', authController.emailController, keyboardType: TextInputType.emailAddress),
        Container(
          height: 20,
        ),
        Obx(
          () => authWidgets.buildProceedButton(
            text: 'Reset',
            onTap: authController.email.value == ''
                ? null
                : () {
                    authController.resetPassword();
                  },
          ),
        ),
        Container(
          height: 30,
        ),
        authWidgets.buildToLoginAccount(),
      ],
    );
  }
}

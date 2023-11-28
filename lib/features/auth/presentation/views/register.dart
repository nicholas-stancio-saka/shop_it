import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/auth/presentation/widgets/auth_widgets.dart';

class RegisterScreen extends StatelessWidget {
  final AuthWidgets authWidgets;
  final AuthController authController;

  const RegisterScreen(this.authWidgets, this.authController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        authWidgets.buildTitle(),
        Container(
          height: 100,
        ),
        authWidgets.buildTextFields('Email', authController.emailController, keyboardType: TextInputType.emailAddress),
        Container(
          height: 20,
        ),
        authWidgets.buildPasswordTextFields('Password', authController.passwordController, authController.isPasswordHidden),
        Container(
          height: 20,
        ),
        authWidgets.buildPasswordTextFields('Re-enter Password', authController.rePasswordController, authController.isPasswordHidden),
        Container(
          height: 10,
        ),
        authWidgets.buildToResetPassword(),
        Container(
          height: 20,
        ),
        Obx(
          () => authWidgets.buildProceedButton(
            text: 'Register',
            onTap: authController.email.value == '' || authController.password.value == '' || authController.rePassword.value == ''
                ? null
                : () {
                    authController.register();
                  },
          ),
        ),
        Container(
          height: 20,
        ),
        authWidgets.buildToLoginAccount(),
      ],
    );
  }
}

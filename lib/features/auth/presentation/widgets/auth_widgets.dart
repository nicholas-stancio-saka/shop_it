import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop_it/core/theme.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/text.dart';

class AuthWidgets {
  final AuthController authController;

  AuthWidgets(this.authController);

  // ----- Main Widgets -----
  Widget buildTitle() {
    // TODO: Get high res image
    return SizedBox(
      width: 300,
      child: Image.asset(
        'assets/images/logo-text.png',
      ),
    );
  }

  Widget buildTextFields(String labelText, TextEditingController controller, {TextInputType? keyboardType, Widget? prefixIcon}) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      keyboardType: keyboardType,
      enabledBorder: authController.errorMessage.value == null
          ? null
          : OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.error),
            ),
      prefixIcon: prefixIcon,
    );
  }

  Widget buildPasswordTextFields(String labelText, TextEditingController controller, RxBool isPasswordHiddenLogic) {
    return Obx(
      () => AppTextField(
        controller: controller,
        labelText: labelText,
        enabledBorder: authController.errorMessage.value == null
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
                    Icons.visibility,
                    color: Colors.black54,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Colors.black54,
                  ),
          ),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget buildProceedButton({required String text, void Function()? onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        onTap: onTap,
        child: Text(
          text,
        ),
      ),
    );
  }

  // ----- Error handling -----
  Widget buildErrorMessage() {
    return Positioned(
      bottom: 75,
      left: 0,
      right: 0,
      child: Obx(() {
        if (authController.errorMessage.value != null) {
          return Text(
            authController.errorMessage.value!,
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
  Widget buildAutoFill() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: AppButton(
          onTap: () {
            authController.emailController.text = 'tes@gmail.com';
            authController.passwordController.text = '123456';
            authController.rePasswordController.text = '123456';
          },
          child: const Text('Auto Fill'),
        ),
      ),
    );
  }

  // ----- Page specific -----
  Widget buildToResetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            authController.toResetPassword();
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              letterSpacing: 0.1,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  // ----- Page specific -----
  Widget buildToLoginAccount() {
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
            authController.toLogin();
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/theme.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/auth/presentation/views/login.dart';
import 'package:shop_it/features/auth/presentation/views/register.dart';
import 'package:shop_it/features/auth/presentation/views/reset_password.dart';
import 'package:shop_it/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/page.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final AuthWidgets authWidgets = AuthWidgets(authController);

    return AppPage(
      body: Stack(
        children: [
          Container(), // To make full height
          _buildSelfApiToggle(),
          if (AppConfig.appType != AppType.release) _buildAutoFill(),
          _buildErrorMessage(),
          SingleChildScrollView(
            child: Container(
              width: 500, // This will adjust for large screens
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Obx(() {
                if (authController.currentPage.value == AuthPages.register) {
                  return RegisterScreen(authWidgets, authController);
                } else if (authController.currentPage.value == AuthPages.resetPassword) {
                  return ResetPasswordScreen(authWidgets, authController);
                }

                // Default
                return LoginScreen(authWidgets, authController);
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ----- Error handling -----
  Widget _buildErrorMessage() {
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
  Widget _buildAutoFill() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: AppButton(
          onTap: () {
            // https://fakestoreapi.com/docs
            authController.emailController.text = 'mor_2314';
            authController.passwordController.text = '83r5^_';
            authController.rePasswordController.text = '83r5^_';
          },
          child: const Text('Auto Fill'),
        ),
      ),
    );
  }

  // ----- Additional Feature -----
  Widget _buildSelfApiToggle() {
    return Obx(
      () => authController.showPersonalApiToggle.value
          ? Positioned(
              bottom: 10,
              left: 20,
              right: 0,
              child: Row(
                children: [
                  Obx(() => Switch(
                        value: authController.usePersonalApi.value,
                        onChanged: (value) async => await authController.updatePersonalApi(value),
                      )),
                  Container(
                    width: 10,
                  ),
                  Text(
                    'Use Peronal API',
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}

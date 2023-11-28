import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/auth/presentation/views/login.dart';
import 'package:shop_it/features/auth/presentation/views/register.dart';
import 'package:shop_it/features/auth/presentation/views/reset_password.dart';
import 'package:shop_it/features/auth/presentation/widgets/auth_widgets.dart';
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
          if (AppConfig.appType != AppType.release) authWidgets.buildAutoFill(),
          authWidgets.buildErrorMessage(),
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
}

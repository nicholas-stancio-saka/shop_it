import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/card.dart';
import 'package:shop_it/features/shared/widgets/page.dart';

class AppErrorPage extends StatelessWidget {
  final String? message;
  final String? buttonText;
  final VoidCallback? callback;

  const AppErrorPage({super.key, this.message, this.buttonText, this.callback});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWidthSmall = constraints.maxWidth < 200;
        bool isHeightSmall = constraints.maxHeight < 200;

        return Center(
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message ?? "An error occurred"),
                if (!isWidthSmall && !isHeightSmall) const SizedBox(height: 20),
                AppButton(
                  onTap: callback,
                  child: Text(buttonText ?? (isWidthSmall ? "Retry" : "Retry the operation")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Default error 404 page
class GlobalErrorPage extends StatelessWidget {
  const GlobalErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: AppErrorPage(
        message: 'An error occured. Please relogin',
        buttonText: 'Back to login',
        callback: () {
          Get.offAllNamed('/auth');
        },
      ),
    );
  }
}

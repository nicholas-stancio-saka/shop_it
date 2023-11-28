import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_it/core/config/config.dart';

class AppGlobalLoader {
  static void showLoading() {
    EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void hideLoading() {
    EasyLoading.dismiss();
  }

  @Deprecated('Old Show Loading')
  static void showLoadingV1() {
    if (AppConfig.navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
        context: AppConfig.navigatorKey.currentState!.overlay!.context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false, // Prevent dialog from closing on back press
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  @Deprecated('Old Hide Loading')
  static void hideLoadingV1() {
    if (AppConfig.navigatorKey.currentContext != null) {
      Navigator.of(AppConfig.navigatorKey.currentContext!, rootNavigator: true).pop();
    }
  }
}

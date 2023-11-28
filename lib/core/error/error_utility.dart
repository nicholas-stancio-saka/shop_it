import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';
import 'package:shop_it/core/services/utils/logging.dart';
import 'package:shop_it/features/shared/widgets/dialog.dart';

class AppErrorUtility {
  static Future<void> defaultErrorDialog(ErrorModel errorModel) async {
    String title = errorModel.shownTitle;
    String text = errorModel.shownText;

    if (AppConfig.appType != AppType.release) {
      if (errorModel.debugTitle == null) {
        if (errorModel.error is DioException) {
          title = 'API Error';
        } else {
          title = 'Debug Error';
        }
      }

      if (errorModel.debugText == null) {
        if (errorModel.error is DioException) {
          text = (errorModel.error as DioException).response.toString();
        } else {
          text = errorModel.error.toString();
        }
      }
    }

    if (errorModel.sendError) {
      logError(errorModel);
    }

    // Force Hide Loading
    AppGlobalLoader.hideLoading();

    await Get.dialog(
      AppSimpleDialog(
        title: title,
        text: text,
        onPressed: errorModel.userRecoveryOption,
      ),
    );
  }

  static void logError(ErrorModel errorModel) async {
    if (AppConfig.appType == AppType.debug) {
      // Debug
      FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: errorModel.error, stack: errorModel.stackTrace));
    } else if (AppConfig.appType == AppType.profile) {
      // Profile
      FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: errorModel.error, stack: errorModel.stackTrace));

      await _sendToCrashlytics(errorModel);
    } else {
      // Release
      await _sendToCrashlytics(errorModel);
    }
  }

  static Future<void> _sendToCrashlytics(ErrorModel errorModel) async {
    try {
      FirebaseCrashlytics.instance.recordError(
        errorModel.error,
        errorModel.stackTrace,
        fatal: errorModel.isFatal,
        information: [ErrorModel],
        reason: (errorModel.debugTitle ?? '') + (errorModel.debugText ?? ''),
      );
    } catch (e) {
      AppLogging.simpleLog('Crashlytics Error: $e');
    }
  }
}

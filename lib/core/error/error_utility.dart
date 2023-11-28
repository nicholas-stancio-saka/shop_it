import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';
import 'package:shop_it/core/services/utils/logging.dart';
import 'package:shop_it/features/shared/widgets/dialog.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

      await _sendToSentry(errorModel);
    } else {
      // Release
      await _sendToSentry(errorModel);
    }
  }

  static Future<void> _sendToSentry(ErrorModel errorModel) async {
    try {
      await Sentry.captureException(
        errorModel.error,
        stackTrace: errorModel.stackTrace,
        hint: Hint.withMap(errorModel.toJson()),
      );
    } catch (e) {
      AppLogging.simpleLog('Sentry Error: $e');
    }
  }
}

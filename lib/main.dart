import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/features/shared/widgets/error_page.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/config/firebase_options.dart';
import 'package:shop_it/core/dependency_injection.dart';
import 'package:shop_it/core/services/storage/local_storage_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shop_it/router.dart';
import 'package:shop_it/core/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // creates a zone
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('id_ID', null);

    await initializeServices();
    initializeDependencies();
    await initErrorManagement();

    runApp(const MyApp());
  }, (e, st) async {
    // Handle Dart errors
    AppErrorUtility.logError(
      ErrorModel(
        type: ErrorType.flutter,
        error: e,
        stackTrace: st,
        debugTitle: 'runZonedGuarded Error',
        debugText: 'Dart errors (Catched on main.dart)',
        isFatal: true,
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: AppConfig.navigatorKey,
      debugShowCheckedModeBanner: false,
      enableLog: false, // GETX Log
      title: 'My Profida',
      theme: AppTheme.themeData,
      initialRoute: '/',
      getPages: AppRouter.mainRoute,
      builder: EasyLoading.init(),
    );
  }
}

Future<void> initializeServices() async {
  if (AppConfig.appType == AppType.release) {
    // Release Mode
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatformRelease,
    );
  } else {
    // Debug Mode
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatformDebug,
    );
  }

  // Initialize Get Storage
  await LocalStorageService.initStorage(); // Ensure GetStorage is initialized
}

/// Sentry Console: https://508598dbec2a.sentry.io/issues/?referrer=sidebar
Future<void> initErrorManagement() async {
  if (AppConfig.appType != AppType.debug) {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://7d24f988656186c99424bacfb929df05@o4506235027259392.ingest.sentry.io/4506235028439040'; // TODO: Secret
      },
    );

    FlutterError.onError = (FlutterErrorDetails details) {
      // Handle Flutter framework errors
      AppErrorUtility.logError(
        ErrorModel(
          type: ErrorType.flutter,
          error: details.exception,
          stackTrace: details.stack,
        ),
      );

      //! Note: Dont send dialogs here
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Handle widget rendering errors
      AppErrorUtility.logError(
        ErrorModel(
          type: ErrorType.flutter,
          error: details.exception,
          stackTrace: details.stack,
        ),
      );

      return const GlobalErrorPage();
    };

    //? Dart error ada di func main
  }
}

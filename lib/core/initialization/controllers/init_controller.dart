import 'package:get/get.dart';
import 'package:shop_it/core/dependency_injection.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/core/services/network/api/app_api.dart';
import 'package:shop_it/core/services/network/api_health_check_service.dart';
import 'package:shop_it/core/services/network/dio.dart';
import 'package:shop_it/core/services/storage/local_storage_service.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';

/// This controller will called on every time this app loads, and is the starting point
///
/// NOTE: Controller ini dibuat dengan tujuan aplikasi [website].
/// Android atau OS lainnya bisa menggunakan ini, tapi sangat bisa dipersimpel
class InitController extends GetxController {
  final ApiHealthCheckService _apiHealthCheckService;
  final LocalStorageService _localStorageService;

  InitController(
    ApiHealthCheckService apiHealthCheckService,
    LocalStorageService localStorageService,
  )   : _apiHealthCheckService = apiHealthCheckService,
        _localStorageService = localStorageService;

  @override
  void onReady() {
    super.onReady();
    checkInitialStatus();
  }

  Future<void> checkInitialStatus() async {
    AppGlobalLoader.showLoading();

    try {
      // Perform API readiness check
      await _apiHealthCheckService.checkApiHealth();

      await _checkAuth();
    } catch (e) {
      /// Handle when API / Connection is having issues
      /// This is the worse case scenario and should not happen
      ///
      /// This can be handled better by:
      /// 1. Implementing offline capability
      /// 2. Create a temporary page while checking API
      /// 3. Give user documentations to try and fix the issue

      // await AppErrorUtility.defaultErrorDialog(
      //   ErrorModel(
      //     type: ErrorType.network,
      //     error: e,
      //     stackTrace: st,
      //     isFatal: true,
      //     shownText: 'A fatal error occured. Please restart the app',
      //   ),
      // );

      // ----- // ----- // -----
      /// On Android, throw to login instead. Let Login Feature handle
      Get.toNamed('/auth');
    }

    AppGlobalLoader.hideLoading();
  }

  Future<void> _checkAuth() async {
    try {
      // Get saved token
      final token = await _localStorageService.read(StorageKeys.token);

      //! USE THIS IF API IS DOWN
      // const String token = 'TEMPORARY TOKEN';

      // Check token status
      final isValid = await _validateToken(token);

      if (isValid) {
        initializeAfterAuthDependencies(token!);

        Get.toNamed('/home'); // Navigate to the home screen if valid
      } else {
        Get.toNamed('/auth'); // Navigate to the login screen if not valid
      }
    } catch (e, st) {
      // Navigate to the login screen if an error occured
      Get.toNamed('/auth');

      AppErrorUtility.logError(
        ErrorModel(
          type: ErrorType.network,
          error: e,
          stackTrace: st,
        ),
      );
    }
  }

  /// This function pings to '/ping-secure'
  Future<bool> _validateToken(String? token) async {
    try {
      // Should not use DI AppDio for this, create new dio instance instead
      final dioToken = AppDio.initAppDioTokenInstance(token!, addWrapper: false);

      await AppApi(dio: dioToken).securePing();

      return true;
    } catch (e) {
      // Token is not valid
      return false;
    }
  }
}

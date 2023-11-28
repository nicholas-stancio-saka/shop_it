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
    } catch (e, st) {
      await AppErrorUtility.defaultErrorDialog(
        ErrorModel(
          type: ErrorType.network,
          error: e,
          stackTrace: st,
          isFatal: true,
          shownText: 'A fatal error occured. Please restart the app',
        ),
      );
    }

    AppGlobalLoader.hideLoading();
  }

  Future<void> _checkAuth() async {
    try {
      // Get saved token
      final token = await _localStorageService.read(StorageKeys.token);

      // Check token status
      final isValid = await _validateToken(token);

      if (isValid) {
        initializeAfterAuthDependencies(token!);

        Get.toNamed('/home'); // Navigate to the home screen if valid
      } else {
        Get.toNamed('/login'); // Navigate to the login screen if not valid
      }
    } catch (e, st) {
      // Navigate to the login screen if an error occured
      Get.toNamed('/login');

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
      // Should not use AppDio for this, create new dio instance instead
      final dioToken = AppDio.initAppDioTokenInstance(token!, addWrapper: false);

      await AppApi(dio: dioToken).securePing();

      return true;
    } catch (e) {
      // Token is not valid
      return false;
    }
  }
}

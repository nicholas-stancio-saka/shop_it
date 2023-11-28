part of '../app_api.dart';

extension UtilityApi on AppApi {
  // Redirect to login or handle the auth failure
  void _handleAuthRedirect() {
    Get.offAllNamed('/login');
  }

  /// Check API (Without Token)
  ///
  /// Will not throw error if unauthenticated
  Future<void> ping() async {
    await dio.get('/ping');
  }

  /// Check API (With Token)
  ///
  /// Should throw error if unauthenticated
  Future<void> securePing() async {
    await dio.get('/secure-ping');
  }
}

// ignore_for_file: unused_element

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
    // await dio.get('/docs');
  }

  /// Check API (With Token)
  ///
  /// Should throw error if unauthenticated
  ///
  /// Note: This will never return error since there is no auth in the API
  Future<void> securePing() async {
    // await dio.get('/docs');
  }
}

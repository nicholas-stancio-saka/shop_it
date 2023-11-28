part of '../app_api.dart';

extension AuthApi on AppApi {
  Future<Map<String, dynamic>> loginWithEmail(Map<String, dynamic> data) async {
    final response = await dio.post('/auth/login', data: data);

    return response.data;
  }

  Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
    final response = await dio.post('/users', data: data);

    return response.data;
  }

  Future<Map<String, dynamic>> getUser(int userId) async {
    final response = await dio.get('/users/$userId');

    return response.data;
  }

  Future<void> logout() async {
    // There is no logout feature in api.
  }
}

part of '../app_api.dart';

extension AuthApi on AppApi {
  Future<Map<String, dynamic>> loginWithEmail(Map<String, dynamic> data) async {
    final response = await dio.post('/login', data: data);

    return response.data;
  }

  Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
    final response = await dio.post('/register', data: data);

    return response.data;
  }
}

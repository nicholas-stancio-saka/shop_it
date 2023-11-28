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

  // TODO: IMPLEMENT THIS
  Future<void> resetEmailPassword(String email) async {
    // await AppFirebaseAuth().resetEmailPassword(email);
  }

  // Remove all storage
  Future<void> logout() async {
    await AppFirebaseAuth().signOut();
  }
}

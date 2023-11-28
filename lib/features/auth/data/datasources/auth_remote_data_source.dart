import 'package:shop_it/core/services/network/api/app_api.dart';
import 'package:shop_it/features/auth/data/models/auth_request.dart';

class AuthRemoteDataSource {
  final AppApi _appApi;

  AuthRemoteDataSource(this._appApi);

  Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    return await _appApi.loginWithEmail(AuthRequest(user: UserRequest(email: email, password: password)).toJson());
  }

  Future<Map<String, dynamic>> createAccount(String email, String password) async {
    return await _appApi.createAccount(AuthRequest(user: UserRequest(email: email, password: password)).toJson());
  }
}

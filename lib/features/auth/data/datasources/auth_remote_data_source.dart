import 'package:shop_it/core/services/network/api/app_api.dart';
import 'package:shop_it/features/auth/data/models/auth_utils.dart';
import 'package:shop_it/features/auth/data/models/login_request.dart';
import 'package:shop_it/features/auth/data/models/register_request.dart';

class AuthRemoteDataSource {
  final AppApi _appApi;

  AuthRemoteDataSource(this._appApi);

  Future<Map<String, dynamic>> loginWithEmail(String username, String password) async {
    return await _appApi.loginWithEmail(LoginRequest(
      username: username,
      password: password,
    ).toJson());
  }

  Future<Map<String, dynamic>> createAccount(String username, String password) async {
    return await _appApi.createAccount(RegisterRequest(
      email: '',
      username: username,
      password: password,
      name: Name(firstname: '', lastname: ''),
      address: Address(
        city: '',
        street: '',
        number: 0,
        zipcode: '',
        geolocation: Geolocation(lat: '', long: ''),
      ),
      phone: '',
    ).toJson());
  }

  Future<Map<String, dynamic>> getUser(int userId) async {
    return await _appApi.getUser(userId);
  }
}

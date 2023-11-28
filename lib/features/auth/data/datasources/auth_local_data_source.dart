import 'package:shop_it/core/services/storage/local_storage_service.dart';

class AuthLocalDataSource {
  final LocalStorageService _localStorageService;

  AuthLocalDataSource(this._localStorageService);

  Future<void> saveToken(String token) async {
    await _localStorageService.write(StorageKeys.token, token);
  }

  Future<void> saveUserID(int userId) async {
    await _localStorageService.write(StorageKeys.userId, userId);
  }
}

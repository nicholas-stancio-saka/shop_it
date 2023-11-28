import 'package:shop_it/core/services/storage/local_storage_service.dart';
import 'package:shop_it/features/auth/domain/entities/user.dart';

class AuthLocalDataSource {
  final LocalStorageService _localStorageService;

  AuthLocalDataSource(this._localStorageService);

  Future<void> saveToken(String token) async {
    await _localStorageService.write(StorageKeys.token, token);
  }

  Future<void> saveUser(User user) async {
    await _localStorageService.write(StorageKeys.userId, user.id);
    await _localStorageService.write(StorageKeys.userId, user.name);
  }
}

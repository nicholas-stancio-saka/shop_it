import 'package:shop_it/core/services/storage/local_storage_service.dart';

class HomeLocalDataSource {
  final LocalStorageService _localStorageService;

  HomeLocalDataSource(this._localStorageService);

  Future<void> purgeStorage() async {
    await _localStorageService.purge();
  }
}

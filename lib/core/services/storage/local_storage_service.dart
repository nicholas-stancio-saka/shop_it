import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final GetStorage _box;

  LocalStorageService() : _box = GetStorage(); // You can use named storage if necessary

  static Future<void> initStorage() async {
    await GetStorage.init(); // Initialize storage, typically called at app startup
  }

  // Write data to local storage
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // Read data from local storage
  T? read<T>(String key) {
    return _box.read(key);
  }

  // Check if a key exists in local storage
  bool hasData(String key) {
    return _box.hasData(key);
  }

  // Remove data from local storage
  Future<void> remove(String key) async {
    await _box.remove(key);
  }
}

class StorageKeys {
  static const String token = 'token';
  static const String userId = 'userId';
}

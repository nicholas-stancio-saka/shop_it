import 'package:shop_it/features/home/data/datasources/home_local_data_source.dart';
import 'package:shop_it/features/home/data/datasources/home_remote_data_source.dart';

class LogoutUser {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  LogoutUser(this._homeRemoteDataSource, this._homeLocalDataSource);

  Future<void> execute() async {
    // Purge Local Storage
    await _homeLocalDataSource.purgeStorage();

    // Hit Logout API
    await _homeRemoteDataSource.logout();
  }
}

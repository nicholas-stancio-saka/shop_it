import 'package:shop_it/features/home/data/datasources/home_remote_data_source.dart';

class LogoutUser {
  final HomeRemoteDataSource _homeRemoteDataSource;

  LogoutUser(this._homeRemoteDataSource);

  Future<void> execute() async {
    await _homeRemoteDataSource.logout();
  }
}

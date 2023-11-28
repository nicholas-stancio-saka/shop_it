import 'package:shop_it/core/services/network/api/app_api.dart';

class HomeRemoteDataSource {
  final AppApi _appApi;

  HomeRemoteDataSource(this._appApi);

  Future<void> logout() async {
    return await _appApi.logout();
  }
}

import 'package:shop_it/core/services/network/api/app_api.dart';

class ApiHealthCheckService {
  final AppApi _appApi;

  ApiHealthCheckService(this._appApi);

  /// This function pings to '/ping' to check API status
  /// Dio will throw an error if response code 4xx/5xx
  Future<void> checkApiHealth() async {
    await _appApi.ping();
  }
}

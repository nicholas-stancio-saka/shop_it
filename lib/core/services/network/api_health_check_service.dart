import 'package:shop_it/core/services/network/api/app_api.dart';

/// NOTE: Api ini dibuat dengan tujuan
/// 1. Untuk web dev
/// 2. Untuk membantu cek backend health (Kondisi server: tidak nyala 24 jam, jadi harus ada checking)
///
/// Bisa dihapus jika server nyala 24 jam atau tidak digunakan
class ApiHealthCheckService {
  final AppApi _appApi;

  ApiHealthCheckService(this._appApi);

  /// This function pings to '/ping' to check API status
  /// Dio will throw an error if response code 4xx/5xx
  Future<void> checkApiHealth() async {
    await _appApi.ping();
  }
}

import 'package:shop_it/core/services/network/api/app_api.dart';

class CartRemoteDataSource {
  final AppApi _appApi;

  CartRemoteDataSource(this._appApi);

  Future<Map<String, dynamic>> getCart() async {
    return await _appApi.getCart();
  }

  Future<Map<String, dynamic>> updateCart(Map<String, dynamic> data) async {
    return await _appApi.updateCart(data);
  }

  Future<Map<String, dynamic>> deleteCart() async {
    return await _appApi.deleteCart();
  }

  // TODO: Create centralized product remote data source
  Future<Map<String, dynamic>> getProduct(int productId) async {
    return await _appApi.getProduct(productId);
  }
}

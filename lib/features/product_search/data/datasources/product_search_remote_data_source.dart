import 'package:shop_it/core/services/network/api/app_api.dart';

class ProductSearchRemoteDataSource {
  final AppApi _appApi;

  ProductSearchRemoteDataSource(this._appApi);

  // There is no search API. so fetch all products and manually search
  Future<List<dynamic>> getAllProductList() async {
    return await _appApi.getAllProducts();
  }
}

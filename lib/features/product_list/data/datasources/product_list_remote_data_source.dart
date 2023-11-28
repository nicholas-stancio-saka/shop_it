import 'package:shop_it/core/services/network/api/app_api.dart';

class ProductListRemoteDataSource {
  final AppApi _appApi;

  ProductListRemoteDataSource(this._appApi);

  Future<List<dynamic>> getCategoryList() async {
    return await _appApi.getAllCategories();
  }

  Future<List<dynamic>> getProductList(String categoryId) async {
    return await _appApi.getProductInCategory(categoryId);
  }
}

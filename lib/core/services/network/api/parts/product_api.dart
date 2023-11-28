part of '../app_api.dart';

extension ProductApi on AppApi {
  Future<Map<String, dynamic>> getAllCategories() async {
    final response = await dio.get('/products/categories');

    return response.data;
  }

  Future<Map<String, dynamic>> getProductInCategory(String categoryName) async {
    final response = await dio.get('/products/category/$categoryName');

    return response.data;
  }
}

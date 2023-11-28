part of '../app_api.dart';

extension ProductApi on AppApi {
  Future<List<dynamic>> getAllCategories() async {
    final response = await dio.get('/products/categories');

    return response.data;
  }

  Future<List<dynamic>> getProductInCategory(String categoryId) async {
    final response = await dio.get('/products/category/$categoryId');

    return response.data;
  }
}
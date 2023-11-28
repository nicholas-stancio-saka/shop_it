part of '../app_api.dart';

extension CartApi on AppApi {
  Future<Map<String, dynamic>> getUserCart(int userId) async {
    final response = await dio.get('/carts/user/$userId');

    return response.data;
  }

  Future<Map<String, dynamic>> addProductToCart(Map<String, dynamic> data) async {
    final response = await dio.post('/carts', data: data);

    return response.data;
  }

  Future<Map<String, dynamic>> updateProductInCart(Map<String, dynamic> data) async {
    final response = await dio.put('/carts', data: data);

    return response.data;
  }
}

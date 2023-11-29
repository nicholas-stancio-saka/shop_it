part of '../app_api.dart';

extension CartApi on AppApi {
  // Since the API is static, I will be using cart ID 1

  Future<Map<String, dynamic>> getCart() async {
    final response = await dio.get('/carts/1');

    return response.data;
  }

  Future<Map<String, dynamic>> updateCart(Map<String, dynamic> data) async {
    final response = await dio.put('/carts/1', data: data);

    return response.data;
  }

  Future<Map<String, dynamic>> deleteCart() async {
    final response = await dio.delete('/carts/1');

    return response.data;
  }
}

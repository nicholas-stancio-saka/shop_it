import 'dart:convert';

import 'package:shop_it/features/cart/data/models/cart_response.dart';

class CartRequest {
  final int userId;
  final DateTime date;
  final List<ProductDTO> products;

  CartRequest({
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartRequest.fromRawJson(String str) => CartRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<ProductDTO>.from(json["products"].map((x) => ProductDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

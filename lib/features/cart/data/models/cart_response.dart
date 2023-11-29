import 'dart:convert';

class CartResponse {
  final int id;
  final int userId;
  final DateTime date;
  final List<ProductDTO> products;
  final int v;

  CartResponse({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartResponse.fromRawJson(String str) => CartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<ProductDTO>.from(json["products"].map((x) => ProductDTO.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class ProductDTO {
  final int productId;
  final int quantity;

  ProductDTO({
    required this.productId,
    required this.quantity,
  });

  factory ProductDTO.fromRawJson(String str) => ProductDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

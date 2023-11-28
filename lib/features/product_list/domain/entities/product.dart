import 'dart:convert';

class Product {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final String rating;
  final String reviewCount;
  final double price;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.price,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        imageUrl: json["image_url"],
        name: json["name"],
        description: json["description"],
        rating: json["rating"],
        reviewCount: json["review_count"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "name": name,
        "description": description,
        "rating": rating,
        "review_count": reviewCount,
        "price": price,
      };
}

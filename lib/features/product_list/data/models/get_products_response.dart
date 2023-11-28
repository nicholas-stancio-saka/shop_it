import 'dart:convert';

class GetProductResponse {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingDTO rating;

  GetProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory GetProductResponse.fromRawJson(String str) => GetProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProductResponse.fromJson(Map<String, dynamic> json) => GetProductResponse(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingDTO.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

class RatingDTO {
  final double rate;
  final int count;

  RatingDTO({
    required this.rate,
    required this.count,
  });

  factory RatingDTO.fromRawJson(String str) => RatingDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingDTO.fromJson(Map<String, dynamic> json) => RatingDTO(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

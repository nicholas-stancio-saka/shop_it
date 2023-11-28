import 'package:shop_it/features/product_list/data/models/get_products_response.dart';

class Product {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final double rating;
  final int reviewCount;
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

  factory Product.fromGetProductResponse(GetProductResponse getProductResponse) => Product(
        id: getProductResponse.id,
        name: getProductResponse.title,
        imageUrl: getProductResponse.image,
        description: getProductResponse.description,
        rating: getProductResponse.rating.rate,
        reviewCount: getProductResponse.rating.count,
        price: getProductResponse.price,
      );
}

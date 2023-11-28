import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

class ProductListController extends GetxController {
  final categoryList = <Category>[].obs;
  final productList = <Product>[].obs;

  @override
  void onInit() {
    categoryList.value = [
      Category(id: 0, name: 'name'),
      Category(id: 1, name: 'name 1'),
    ];

    productList.value = [
      Product(
        id: 0,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0',
        description: 'Description of Product 0',
        rating: '4.5',
        reviewCount: '10',
        price: 29.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: '4.7',
        reviewCount: '8',
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 0 Product 0 Product 0 Product 0 Product 0 Product 0',
        description: 'Description of Product 1',
        rating: '4.7',
        reviewCount: '8',
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: '4.7',
        reviewCount: '8',
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: '4.7',
        reviewCount: '8',
        price: 59.99,
      ),
    ];

    super.onInit();
  }
}

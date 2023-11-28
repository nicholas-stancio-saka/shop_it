import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_list/domain/usecases/category.dart';
import 'package:shop_it/features/product_list/domain/usecases/product.dart';

class ProductListController extends GetxController {
  // Use cases
  final ProductUseCase _productUseCase;
  final CategoryUseCase _categoryUseCase;

  ProductListController(this._productUseCase, this._categoryUseCase);

  final categoryList = <Category>[].obs;
  final productList = <Product>[].obs;

  void _fetchCategories() async {
    categoryList.value = await _categoryUseCase.call();
  }

  void _fetchProducts(String categoryId) async {
    productList.value = await _productUseCase.call(categoryId);
  }

  @override
  void onInit() {
    _fetchCategories();
    _fetchProducts('electronics');

    productList.value = [
      Product(
        id: 0,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0 Product 0',
        description:
            'Description of Product 0Description of Product 0DescriptioDescription of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0n of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0Description of Product 0',
        rating: 4.5,
        reviewCount: 10,
        price: 29.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: 4.7,
        reviewCount: 8,
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 0 Product 0 Product 0 Product 0 Product 0 Product 0',
        description: 'Description of Product 1',
        rating: 4.7,
        reviewCount: 8,
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: 4.7,
        reviewCount: 8,
        price: 59.99,
      ),
      Product(
        id: 1,
        imageUrl: 'https://via.placeholder.com/150',
        name: 'Product 1',
        description: 'Description of Product 1',
        rating: 4.7,
        reviewCount: 8,
        price: 59.99,
      ),
    ];

    super.onInit();
  }
}

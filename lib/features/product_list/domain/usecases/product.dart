import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_list/domain/repositories/product_list_repository_impl.dart';

class ProductUseCase {
  final ProductListRepository repository;

  ProductUseCase(this.repository);

  Future<List<Product>> callSpecificCategory(String categoryId) async {
    return await repository.getProductList(categoryId);
  }

  Future<List<Product>> callAllCategory() async {
    return await repository.getAllProductList();
  }
}

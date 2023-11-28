import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

abstract class ProductListRepository {
  Future<List<Category>> getCategoryList();
  Future<List<Product>> getProductList(String categoryId);
}

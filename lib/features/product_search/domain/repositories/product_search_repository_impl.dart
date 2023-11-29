import 'package:shop_it/features/product_list/domain/entities/product.dart';

abstract class ProductSearchRepository {
  Future<List<Product>> search(String text);
}

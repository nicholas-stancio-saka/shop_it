import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_search/domain/repositories/product_search_repository_impl.dart';

class SearchUseCase {
  final ProductSearchRepository repository;

  SearchUseCase(this.repository);

  Future<List<Product>> call(String text) async {
    return await repository.search(text);
  }
}

import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/repositories/product_list_repository_impl.dart';

class CategoryUseCase {
  final ProductListRepository repository;

  CategoryUseCase(this.repository);

  Future<List<Category>> call() async {
    return await repository.getCategoryList();
  }
}

import 'package:shop_it/features/product_list/data/datasources/product_list_remote_data_source.dart';
import 'package:shop_it/features/product_list/data/models/get_products_response.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_list/domain/repositories/product_list_repository_impl.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  final ProductListRemoteDataSource remoteDataSource;

  ProductListRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategoryList() async {
    final response = await remoteDataSource.getCategoryList();

    final List<Category> categoryList = [];

    for (var element in response) {
      categoryList.add(
        Category(
          id: element,
          name: element,
        ),
      );
    }

    return categoryList;
  }

  @override
  Future<List<Product>> getProductList(String categoryId) async {
    final response = await remoteDataSource.getProductList(categoryId);

    final List<Product> productList = [];

    for (var element in response) {
      final GetProductResponse getProductResponse = GetProductResponse.fromJson(element);

      productList.add(Product.fromGetProductResponse(getProductResponse));
    }

    return productList;
  }
}

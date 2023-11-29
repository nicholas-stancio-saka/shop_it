import 'package:shop_it/features/product_list/data/models/get_products_response.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_search/data/datasources/product_search_remote_data_source.dart';
import 'package:shop_it/features/product_search/domain/repositories/product_search_repository_impl.dart';

class ProductSearchRepositoryImpl implements ProductSearchRepository {
  final ProductSearchRemoteDataSource remoteDataSource;

  ProductSearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> search(String text) async {
    final response = await remoteDataSource.getAllProductList();

    final List<Product> productList = [];

    for (var element in response) {
      final GetProductResponse getProductResponse = GetProductResponse.fromJson(element);

      // TODO: Need requirements for search logic
      if (getProductResponse.title.toLowerCase().contains(text.toLowerCase())) {
        productList.add(Product.fromGetProductResponse(getProductResponse));
      }
    }

    return productList;
  }
}

import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_list/domain/usecases/category.dart';
import 'package:shop_it/features/product_list/domain/usecases/product.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';

class ProductListController extends GetxController {
  // Use cases
  final ProductUseCase _productUseCase;
  final CategoryUseCase _categoryUseCase;

  ProductListController(this._productUseCase, this._categoryUseCase);

  // State Info
  final viewState = ViewStateInfo(state: ViewState.loading).obs;

  // Data
  final categoryList = <Category>[].obs;
  final productList = <Product>[].obs;

  Future<void> onRefresh() async {
    try {
      viewState.value = ViewStateInfo(state: ViewState.loading);

      await _fetchCategories();
      await _fetchProducts(categoryList[0].id);

      viewState.value = ViewStateInfo(state: ViewState.success);
    } catch (e) {
      viewState.value = ViewStateInfo(
        state: ViewState.failed,
        message: 'Unable to fetch data, please try again later!',
        callback: onRefresh,
      );
    }
  }

  Future<void> updateCategory(Category category) async {
    await _fetchProducts(category.id);
  }

  Future<void> _fetchCategories() async {
    categoryList.value = await _categoryUseCase.call();
  }

  Future<void> _fetchProducts(String categoryId) async {
    productList.value = await _productUseCase.call(categoryId);
  }

  @override
  void onInit() {
    onRefresh();

    super.onInit();
  }
}

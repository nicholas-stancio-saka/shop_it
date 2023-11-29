import 'package:get/get.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
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

  // State Info and obs
  final viewStateCategory = ViewStateInfo(state: ViewState.loading).obs;
  final viewStateProducts = ViewStateInfo(state: ViewState.loading).obs;

  // Data
  final categoryList = <Category>[].obs;
  final productList = <Product>[].obs;

  late Category selectedCategory;

  Future<void> onRefresh() async {
    await _fetchCategories();
    await updateProducts(selectedCategory);
  }

  Future<void> updateProducts(Category newCategory) async {
    try {
      viewStateProducts.value = ViewStateInfo(state: ViewState.loading);

      selectedCategory = newCategory;

      if (newCategory.id == 'all') {
        await _fetchAllProducts();
      } else {
        await _fetchProducts(newCategory.id);
      }

      viewStateProducts.value = ViewStateInfo(state: ViewState.success);
    } catch (e, st) {
      viewStateProducts.value = ViewStateInfo(
        state: ViewState.failed,
        message: 'Unable to fetch data, please try again later!',
        callback: onRefresh,
      );

      // Log Error
      AppErrorUtility.logError(ErrorModel(
        type: ErrorType.presentation,
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<void> _fetchCategories() async {
    try {
      viewStateCategory.value = ViewStateInfo(state: ViewState.loading);

      categoryList.value = await _categoryUseCase.call();

      // Insert the All category
      categoryList.insert(0, Category(id: 'all', name: 'all'));
      selectedCategory = categoryList[0];

      viewStateCategory.value = ViewStateInfo(state: ViewState.success);
    } catch (e, st) {
      viewStateCategory.value = ViewStateInfo(
        state: ViewState.failed,
        message: 'Unable to fetch data, please try again later!',
        callback: onRefresh,
      );

      // Log Error
      AppErrorUtility.logError(ErrorModel(
        type: ErrorType.presentation,
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<void> _fetchProducts(String categoryId) async {
    productList.value = await _productUseCase.callSpecificCategory(categoryId);
  }

  Future<void> _fetchAllProducts() async {
    productList.value = await _productUseCase.callAllCategory();
  }

  @override
  void onInit() {
    onRefresh();

    super.onInit();
  }
}

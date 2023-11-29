import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_search/domain/usecases/search.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';

class ProductSearchController extends GetxController {
  // Use cases
  final SearchUseCase _searchUseCase;

  ProductSearchController(this._searchUseCase);

  final viewState = ViewStateInfo(state: ViewState.success).obs;
  final productList = <Product>[].obs;

  final searchTextController = TextEditingController();
  final searchText = ''.obs;

  void toCart() {
    Get.toNamed('/cart');
  }

  void clear() {
    searchTextController.text = '';
    updateSearchText('');
  }

  void updateSearchText(String newText) {
    searchText.value = newText;
  }

  void _search(String text) async {
    try {
      viewState.value = ViewStateInfo(state: ViewState.loading);

      await _fetchProducts(text);

      viewState.value = ViewStateInfo(state: ViewState.success);
    } catch (e, st) {
      viewState.value = ViewStateInfo(
        state: ViewState.failed,
        message: 'Unable to fetch data, please try again later!',
        callback: () => _search(text),
      );

      // Log Error
      AppErrorUtility.logError(ErrorModel(
        type: ErrorType.presentation,
        error: e,
        stackTrace: st,
      ));
    }
  }

  Future<void> _fetchProducts(String text) async {
    productList.value = await _searchUseCase.call(text);
  }

  @override
  void onInit() {
    super.onInit();

    debounce(searchText, (text) => _search(text), time: const Duration(seconds: 1));
  }
}

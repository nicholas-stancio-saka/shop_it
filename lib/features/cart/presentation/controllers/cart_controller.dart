import 'package:get/get.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';
import 'package:shop_it/features/cart/domain/entities/cart.dart';
import 'package:shop_it/features/cart/domain/entities/cart_item.dart';
import 'package:shop_it/features/cart/domain/usecases/delete_cart.dart';
import 'package:shop_it/features/cart/domain/usecases/get_cart.dart';
import 'package:shop_it/features/cart/domain/usecases/update_cart.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';

class CartController extends GetxController {
  // Use cases
  final DeleteCartUseCase _deleteCartUseCase;
  final UpdateCartUseCase _updateCartUseCase;
  final GetCartUseCase _getCartUseCase;

  CartController(this._deleteCartUseCase, this._updateCartUseCase, this._getCartUseCase);

  final viewState = ViewStateInfo(state: ViewState.success).obs;
  final totalPrice = 0.0.obs;
  final cart = Cart(cartItems: []).obs;

  Future<void> onRefresh() async {
    await _getCart();
  }

  Future<void> clearCart() async {
    cart.value = await _deleteCartUseCase.call();
  }

  void handleOnRemove(CartItem cartItem) {
    int index = cart.value.cartItems.indexWhere((item) => item.productId == cartItem.productId);
    if (index != -1) {
      if (cart.value.cartItems[index].qty > 1) {
        cart.value.cartItems[index].qty--;
      } else {
        cart.value.cartItems.removeAt(index);
      }
      cart.refresh();
      _calculateTotalPrice();
    }
  }

  void handleOnAdd(CartItem cartItem) {
    int index = cart.value.cartItems.indexWhere((item) => item.productId == cartItem.productId);
    if (index != -1) {
      cart.value.cartItems[index].qty++;
      cart.refresh();
      _calculateTotalPrice();
    }
  }

  void handleOnDelete(CartItem cartItem) {
    cart.value.cartItems.removeWhere((item) => item.productId == cartItem.productId);
    cart.refresh();
    _calculateTotalPrice();
  }

  Future<void> _getCart() async {
    cart.value = await _getCartUseCase.call();
  }

  Future<void> _updateCart(Cart newCart) async {
    AppGlobalLoader.showLoading();
    try {
      cart.value = await _updateCartUseCase.call(newCart);
    } catch (e, st) {
      AppErrorUtility.defaultErrorDialog(
        ErrorModel(
          type: ErrorType.presentation,
          error: e,
          stackTrace: st,
        ),
      );
    }

    AppGlobalLoader.hideLoading();
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    for (var item in cart.value.cartItems) {
      total += item.price * item.qty;
    }
    totalPrice.value = total;
  }

  @override
  void onInit() {
    cart.listen((_) => _calculateTotalPrice());

    onRefresh();

    super.onInit();
  }
}

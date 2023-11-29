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

  final useApi = true.obs;

  Future<void> onRefresh() async {
    await _getCart();
  }

  Future<void> clearCart() async {
    if (!useApi.value) {
      _clearLocalCart();
      return;
    }

    try {
      AppGlobalLoader.showLoading();

      cart.value = await _deleteCartUseCase.call();
      cart.refresh();
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

  void handleOnRemove(CartItem cartItem) {
    final List<CartItem> items = [...cart.value.cartItems];
    final Cart newCart = Cart(cartItems: items);

    // Find the cart item in the cart
    var itemIndex = newCart.cartItems.indexWhere((item) => item.productId == cartItem.productId);

    if (itemIndex != -1) {
      // Decrement the quantity of the found item
      newCart.cartItems[itemIndex].qty--;

      // If the quantity is now 0, remove the item from the cart
      if (newCart.cartItems[itemIndex].qty < 1) {
        newCart.cartItems.removeAt(itemIndex);
      }

      // Update the local cart
      _updateCart(newCart);
    }
  }

  void handleOnAdd(CartItem cartItem) {
    final List<CartItem> items = [...cart.value.cartItems];
    final Cart newCart = Cart(cartItems: items);

    int itemIndex = newCart.cartItems.indexWhere((item) => item.productId == cartItem.productId);

    if (itemIndex != -1) {
      // Increment the quantity
      newCart.cartItems[itemIndex].qty++;

      _updateCart(newCart);
    }
  }

  void handleOnDelete(CartItem cartItem) {
    final List<CartItem> items = [...cart.value.cartItems];
    final Cart newCart = Cart(cartItems: items);

    int itemIndex = newCart.cartItems.indexWhere((item) => item.productId == cartItem.productId);

    if (itemIndex != -1) {
      // Delete
      newCart.cartItems.removeAt(itemIndex);
    }

    _updateCart(newCart);
  }

  Future<void> _getCart() async {
    cart.value = await _getCartUseCase.call();
  }

  Future<void> _updateCart(Cart newCart) async {
    if (!useApi.value) {
      _updateLocalCart(newCart);
      return;
    }

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

  void _updateLocalCart(Cart newCart) {
    cart.value = newCart;
    cart.refresh();
  }

  void _clearLocalCart() {
    cart.value = Cart(cartItems: []);
    cart.refresh();
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

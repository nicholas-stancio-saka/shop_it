import 'package:get/get.dart';
import 'package:shop_it/features/cart/domain/entities/cart_item.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';

class CartController extends GetxController {
  final viewState = ViewStateInfo(state: ViewState.success).obs;
  final totalPrice = 0.0.obs;
  final cartItemList = <CartItem>[].obs;

  void clearCart() {}

  void handleOnRemove(CartItem cartItem) {}
  void handleOnAdd(CartItem cartItem) {}
  void handleOnDelete(CartItem cartItem) {}
}

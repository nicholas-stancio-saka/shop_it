import 'package:shop_it/features/cart/domain/entities/cart_item.dart';

class Cart {
  final List<CartItem> cartItems;

  Cart({
    required this.cartItems,
  });
}

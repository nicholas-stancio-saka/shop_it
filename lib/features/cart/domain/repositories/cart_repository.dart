import 'package:shop_it/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<Cart> updateCart(Cart cart);
  Future<Cart> deleteCart();
}

import 'package:shop_it/features/cart/domain/entities/cart.dart';
import 'package:shop_it/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartUseCase {
  final CartRepository repository;

  UpdateCartUseCase(this.repository);

  Future<Cart> call(Cart cart) async {
    return await repository.updateCart(cart);
  }
}

import 'package:shop_it/features/cart/domain/entities/cart.dart';
import 'package:shop_it/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Cart> call() async {
    return await repository.getCart();
  }
}

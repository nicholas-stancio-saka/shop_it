import 'package:shop_it/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:shop_it/features/cart/data/models/cart_request.dart';
import 'package:shop_it/features/cart/data/models/cart_response.dart';
import 'package:shop_it/features/cart/domain/entities/cart.dart';
import 'package:shop_it/features/cart/domain/entities/cart_item.dart';
import 'package:shop_it/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_it/features/product_list/data/models/get_products_response.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Cart> getCart() async {
    final response = await remoteDataSource.getCart();
    final CartResponse cartResponse = CartResponse.fromJson(response);

    return Cart(
      cartItems: await _getCartItems(cartResponse),
    );
  }

  @override
  Future<Cart> updateCart(Cart cart) async {
    final List<ProductDTO> products = [];

    for (var element in cart.cartItems) {
      products.add(
        ProductDTO(
          productId: element.productId,
          quantity: element.qty,
        ),
      );
    }

    final CartRequest cartRequest = CartRequest(
      userId: 1,
      date: DateTime.now(),
      products: products,
    );

    final response = await remoteDataSource.updateCart(cartRequest.toJson());
    final CartResponse cartResponse = CartResponse.fromJson(response);

    return Cart(
      cartItems: await _getCartItems(cartResponse),
    );
  }

  @override
  Future<Cart> deleteCart() async {
    final response = await remoteDataSource.deleteCart();
    final CartResponse cartResponse = CartResponse.fromJson(response);

    return Cart(
      cartItems: await _getCartItems(cartResponse),
    );
  }

  Future<List<CartItem>> _getCartItems(CartResponse cartResponse) async {
    final List<CartItem> cartItems = [];

    for (var element in cartResponse.products) {
      final product = await _getProduct(element.productId);

      cartItems.add(
        CartItem(
          productId: element.productId,
          imageUrl: product.imageUrl,
          name: product.name,
          price: product.price,
          qty: element.quantity,
        ),
      );
    }

    return cartItems;
  }

  Future<Product> _getProduct(int productId) async {
    final response = await remoteDataSource.getProduct(productId);
    final GetProductResponse getProductResponse = GetProductResponse.fromJson(response);

    return Product.fromGetProductResponse(getProductResponse);
  }
}

import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

class ProductDetailController extends GetxController {
  addToCart(Product product) {
    // TODO: Implement This
  }

  // ----- Page Navigation -----
  toCart() {
    Get.toNamed('/cart');
  }
}

import 'package:shop_it/core/initialization/views/init_screen.dart';
import 'package:shop_it/features/auth/presentation/views/_auth.dart';
import 'package:shop_it/features/cart/presentation/views/cart.dart';
import 'package:shop_it/features/home/presentation/views/home.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/product_detail/presentation/views/product_detail.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/product_search/presentation/views/search.dart';

/// Application Route Management
class AppRouter {
  static List<GetPage> get mainRoute {
    return [
      GetPage(
        name: '/',
        page: () => const InitScreen(),
      ),
      GetPage(
        name: '/auth',
        page: () => AuthScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
      ),
      GetPage(
        name: '/product_detail',
        page: () => ProductDetail(Get.arguments as Product),
      ),
      GetPage(
        name: '/search',
        page: () => const SearchScreen(),
      ),
      GetPage(
        name: '/cart',
        page: () => const CartScreen(),
      ),
    ];
  }
}

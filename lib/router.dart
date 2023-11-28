import 'package:shop_it/core/initialization/views/init_screen.dart';
import 'package:shop_it/features/auth/presentation/views/_auth.dart';
import 'package:shop_it/features/home/presentation/views/home.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/product_detail/presentation/views/product_detail.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

/// Application Route Management
class AppRouter {
  static List<GetPage> get mainRoute {
    return [
      GetPage(
        name: '/',
        page: () => const InitScreen(),
        transition: Transition.noTransition, // No animation
      ),
      GetPage(
        name: '/auth',
        page: () => AuthScreen(),
        transition: Transition.noTransition, // No animation
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        transition: Transition.noTransition, // No animation
      ),
      GetPage(
        name: '/product_detail',
        page: () => ProductDetail(Get.arguments as Product),
        transition: Transition.noTransition, // Or choose the transition you prefer
      ),
    ];
  }
}

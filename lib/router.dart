import 'package:shop_it/core/initialization/views/init_screen.dart';
import 'package:shop_it/features/auth/presentation/views/login.dart';
import 'package:shop_it/features/home/presentation/views/home.dart';
import 'package:get/get.dart';

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
        name: '/login',
        page: () => LoginScreen(),
        transition: Transition.noTransition, // No animation
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        transition: Transition.noTransition, // No animation
      ),
    ];
  }
}

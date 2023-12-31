import 'package:get/get.dart';
import 'package:shop_it/core/services/utils/global_loader.dart';
import 'package:shop_it/features/home/domain/usecases/logout.dart';

class HomeController extends GetxController {
  final LogoutUser _logoutUseCase;

  // Constructor
  HomeController(LogoutUser logoutUser) : _logoutUseCase = logoutUser;

  // ----- Page Navigation -----
  logout() async {
    AppGlobalLoader.showLoading();

    try {
      await _logoutUseCase.execute();
    } catch (e) {
      // Do Nothing, just throw user
    }

    AppGlobalLoader.hideLoading();
    Get.offAllNamed('/auth');
  }

  toSearch() {
    Get.toNamed('/search');
  }

  toCart() {
    Get.toNamed('/cart');
  }
}

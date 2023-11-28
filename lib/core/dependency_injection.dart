import 'package:get/get.dart';
import 'package:shop_it/core/initialization/controllers/init_controller.dart';
import 'package:shop_it/core/services/network/api/app_api.dart';
import 'package:shop_it/core/services/network/api_health_check_service.dart';
import 'package:shop_it/core/services/network/dio.dart';
import 'package:shop_it/core/services/storage/local_storage_service.dart';
import 'package:shop_it/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:shop_it/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:shop_it/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:shop_it/features/auth/domain/usecases/login_user.dart';
import 'package:shop_it/features/auth/domain/usecases/register_user.dart';
import 'package:shop_it/features/auth/domain/usecases/reset_password.dart';
import 'package:shop_it/features/auth/presentation/controllers/auth_controller.dart';
import 'package:shop_it/features/home/data/datasources/home_local_data_source.dart';
import 'package:shop_it/features/home/data/datasources/home_remote_data_source.dart';
import 'package:shop_it/features/home/domain/usecases/logout.dart';
import 'package:shop_it/features/home/presentation/controllers/home_controller.dart';
import 'package:shop_it/features/product_list/presentation/controllers/product_list_controller.dart';

enum DioTokenType { noToken, token }

/// These dependencies will be called on main()
///
/// None of these dependencies should interact with API with token
void initializeDependencies() {
  // Core services
  final dioNoToken = Get.put(AppApi(dio: AppDio.initAppDioInstance()), permanent: true, tag: DioTokenType.noToken.name);
  final localStorage = Get.put(LocalStorageService(), permanent: true);
  final healthCheck = Get.put(ApiHealthCheckService(dioNoToken), permanent: true);

  Get.put(InitController(healthCheck, localStorage), permanent: true);

  // Auth feature dependencies
  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource(dioNoToken), fenix: true);
  Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSource(localStorage), fenix: true);
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => LoginUser(Get.find()), fenix: true);
  Get.lazyPut(() => RegisterUser(Get.find()), fenix: true);
  Get.lazyPut(() => ResetPassword(Get.find()), fenix: true);

  // Controllers
  Get.lazyPut(() => AuthController(loginUser: Get.find(), registerUser: Get.find(), resetPassword: Get.find()), fenix: true);
}

/// These dependencies will be called after getting the token
void initializeAfterAuthDependencies(String token) {
  // Core services
  final dioToken = Get.put(AppApi(dio: AppDio.initAppDioTokenInstance(token)), permanent: true, tag: DioTokenType.token.name);

  // Home feature dependencies
  Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSource(dioToken), fenix: true);
  Get.lazyPut<HomeLocalDataSource>(() => HomeLocalDataSource(Get.find()), fenix: true);
  Get.lazyPut(() => LogoutUser(Get.find(), Get.find()), fenix: true);

  // Controllers
  Get.lazyPut<HomeController>(() => HomeController(Get.find()), fenix: true);
  Get.lazyPut<ProductListController>(() => ProductListController(), fenix: true);
}

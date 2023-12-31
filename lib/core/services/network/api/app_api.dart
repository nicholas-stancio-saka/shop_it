import 'package:dio/dio.dart';

// Include the parts
part 'parts/utility_api.dart';
part 'parts/auth_api.dart';
part 'parts/cart_api.dart';
part 'parts/product_api.dart';

/// Main API class that handles all network requests.
///
/// This class is split into multiple parts for better organization and maintainability.
/// Each part handles a specific domain of the API.
class AppApi {
  final Dio dio;

  AppApi({required this.dio});
}

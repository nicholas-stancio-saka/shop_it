import 'package:dio/dio.dart';
import 'package:shop_it/features/shared/widgets/dialog.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/core/services/utils/logging.dart';

class AppDio {
  static String baseUrl = AppConfig.baseUrl;
  static const connectTimeout = Duration(seconds: 10); // 10s

  static Dio initAppDioInstance() {
    final Dio dio = Dio();

    dio.interceptors.add(customInterceptorsWrapper());
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.headers['Content-Type'] = 'application/json';

    return dio;
  }

  static Dio initAppDioTokenInstance(String bearerToken, {bool addWrapper = true}) {
    final Dio dio = Dio();

    if (addWrapper) {
      dio.interceptors.add(customInterceptorsWrapper(
        onError: (DioException error, handler) {
          // TODO: Error handling onError?
        },
      ));
    }

    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.headers['Content-Type'] = 'application/json';

    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    return dio;
  }

  static Interceptor customInterceptorsWrapper(
      {void Function(DioException, ErrorInterceptorHandler)? onError, void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse}) {
    return InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      String headers = "";
      options.headers.forEach((key, value) {
        headers += "| $key: $value";
      });

      if (AppConfig.toggleApiLog) {
        AppLogging.simpleLog("┌------------------------------------------------------------------------------");
        AppLogging.simpleLog('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
        AppLogging.simpleLog("├------------------------------------------------------------------------------");
      }

      handler.next(options); //continue
    }, onResponse: (Response response, handler) async {
      if (AppConfig.toggleApiLog) {
        AppLogging.simpleLog("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
        AppLogging.simpleLog("└------------------------------------------------------------------------------");
      }

      if (onResponse != null) {
        onResponse(response, handler); // Custom Error Functions
      }

      handler.next(response); // continue
    }, onError: (DioException error, handler) async {
      if (AppConfig.toggleApiLog) {
        AppLogging.simpleLog("| [DIO] Error: ${error.error}: ${error.response?.data.toString()}");
        AppLogging.simpleLog("└------------------------------------------------------------------------------");
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // If Time out
        const AppSimpleDialog(title: 'Tidak ada koneksi', text: 'Mohon periksa koneksi internet Anda!');
      }

      if (onError != null) {
        onError(error, handler); // Custom Error Functions
      }

      handler.next(error); //continue
    });
  }
}

import 'package:dio/dio.dart';
import 'package:network_caller/Core/utils/constants/app_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'global_error_interceptor.dart';
import 'http_error_interceptor.dart';
import 'internet_check_interceptor.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      InternetCheckInterceptor(),
      GlobalErrorInterceptor(),
      HttpErrorInterceptor(),
      PrettyDioLogger(
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    ]);

    return dio;
  }
}


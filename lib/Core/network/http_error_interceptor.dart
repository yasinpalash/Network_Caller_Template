import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class HttpErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          err = err.copyWith(error: const UnauthorizedException());
          break;
        case 403:
          err = err.copyWith(error: const ForbiddenException());
          break;
        case 404:
          err = err.copyWith(error: const NotFoundException());
          break;
        case >= 500:
          err = err.copyWith(
            error: ServerErrorException("Server error ($statusCode)"),
          );
          break;
        default:
          err = err.copyWith(
            error: NetworkException('HTTP Error: $statusCode'),
          );
          break;
      }
    }

    handler.next(err);
  }
}

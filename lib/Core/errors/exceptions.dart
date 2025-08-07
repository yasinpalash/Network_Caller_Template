class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends NetworkException {
  const NoInternetException() : super("No Internet Connection");
}

class UnexpectedException extends NetworkException {
  const UnexpectedException() : super("Unexpected error occurred");
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException() : super("Unauthorized access");
}

class ForbiddenException extends NetworkException {
  const ForbiddenException() : super("Access forbidden");
}

class NotFoundException extends NetworkException {
  const NotFoundException() : super("Resource not found");
}

class ServerErrorException extends NetworkException {
  const ServerErrorException([super.message = "Server error"]);
}

class TimeoutException extends NetworkException {
  const TimeoutException() : super("Connection timed out");
}

class CancelledException extends NetworkException {
  const CancelledException() : super("Request was cancelled");
}

class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException() : super("Unexpected network error occurred");
}

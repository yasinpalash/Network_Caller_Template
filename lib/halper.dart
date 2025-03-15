import 'package:logger/logger.dart';

class AppLoggerHelper {
  // Private constructor to prevent instantiation
  AppLoggerHelper._();

  // Singleton instance of the logger
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    level: Level.debug,
  );

  /// Logs a debug message
  static void debug(String message) {
    _logger.d(message);
  }

  /// Logs an info message
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message
  static void warning(String message) {
    _logger.w(message);
  }

  /// Logs an error message with optional error details
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  /// Logs a critical message (e.g., for severe errors or system failures)
  static void critical(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error: error, stackTrace: stackTrace ?? StackTrace.current);
  }

  /// Custom log method to specify the log level manually
  static void log(Level level, String message) {
    _logger.log(level, message);
  }
}

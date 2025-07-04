import 'package:logger/logger.dart' as log_package;

import '../../config/env/env_config.dart';

class LoggerService {
  static late log_package.Logger _logger;

  static void init() {
    _logger = log_package.Logger(
      printer: log_package.PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      level: EnvConfig.enableLogging ? log_package.Level.debug : log_package.Level.nothing,
    );
  }

  // Debug log
  static void d(dynamic message) {
    if (EnvConfig.enableLogging) {
      _logger.d(message);
    }
  }

  // Info log
  static void i(dynamic message) {
    if (EnvConfig.enableLogging) {
      _logger.i(message);
    }
  }

  // Warning log
  static void w(dynamic message) {
    if (EnvConfig.enableLogging) {
      _logger.w(message);
    }
  }

  // Error log
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (EnvConfig.enableLogging) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  // For GetX logger
  static void write(String message, {bool isError = false}) {
    if (EnvConfig.enableLogging) {
      if (isError) {
        _logger.e(message);
      } else {
        _logger.d(message);
      }
    }
  }
}

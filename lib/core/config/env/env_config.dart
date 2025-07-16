import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/logger/logger.dart';

enum Environment {
  dev,
  staging,
  prod,
}

class EnvConfig {
  static late Environment environment;
  static late String apiUrl;
  static late bool enableLogging;

  static Future<void> initialize() async {
    try {
      final envString = dotenv.env['ENVIRONMENT'] ?? 'dev';
      environment = _getEnvironmentFromString(envString);

      apiUrl =  dotenv.env['API_URL']! ;
      enableLogging = dotenv.env['ENABLE_LOGGING'] == 'true';

      LoggerService.d('Environment initialized: $environment');
      LoggerService.d('API URL: $apiUrl');
    } catch (e) {
     // LoggerService.e('Failed to initialize environment: $e');
      // Set defaults
      environment = Environment.dev;
      apiUrl =   'http://10.0.2.2:8090';
      enableLogging = true;
    }
  }

  static Environment _getEnvironmentFromString(String env) {
    switch (env.toLowerCase()) {
      case 'prod':
      case 'production':
        return Environment.prod;
      case 'staging':
        return Environment.staging;
      case 'dev':
      case 'development':
      default:
        return Environment.dev;
    }
  }

  static bool get isProduction => environment == Environment.prod;
  static bool get isStaging => environment == Environment.staging;
  static bool get isDevelopment => environment == Environment.dev;
}

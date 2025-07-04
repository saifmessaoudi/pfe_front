import 'package:dio/dio.dart';
import '../../env/env_config.dart';
import '../../../utils/logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (EnvConfig.enableLogging) {
      LoggerService.d('REQUEST[${options.method}] => PATH: ${options.path}');
      LoggerService.d('REQUEST HEADERS: ${options.headers}');
      LoggerService.d('REQUEST DATA: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (EnvConfig.enableLogging) {
      LoggerService.d(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
      LoggerService.d('RESPONSE DATA: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (EnvConfig.enableLogging) {
      LoggerService.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
      LoggerService.e('ERROR MESSAGE: ${err.message}');
      LoggerService.e('ERROR DATA: ${err.response?.data}');
    }
    handler.next(err);
  }
}

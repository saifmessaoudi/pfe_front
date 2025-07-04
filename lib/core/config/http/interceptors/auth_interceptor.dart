import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/app_constants.dart';
import '../../constants/api_constants.dart';
import '../../../utils/logger/logger.dart';

class AuthInterceptor extends Interceptor {
  final _storage = GetStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.read<String>(AppConstants.tokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
      LoggerService.d('Adding auth token to request: ${options.path}');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      LoggerService.w('Received 401 unauthorized error');

      // Clear token and navigate to login
      _storage.remove(AppConstants.tokenKey);
      _storage.remove(AppConstants.userIdKey);

      // Navigate to login screen
      // Get.offAllNamed(AppRoutes.LOGIN);
    }

    handler.next(err);
  }
}

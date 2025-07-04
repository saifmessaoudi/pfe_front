import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/network_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'Connection timed out. Please check your internet connection.',
          statusCode: err.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;

        String message = 'Something went wrong';

        if (data != null && data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
        }

        throw ApiException(
          message: message,
          statusCode: statusCode,
          data: data,
        );

      case DioExceptionType.cancel:
        throw NetworkException(
          message: 'Request was cancelled',
          statusCode: err.response?.statusCode,
        );

      case DioExceptionType.connectionError:
        throw NetworkException(
          message: 'No internet connection',
          statusCode: err.response?.statusCode,
        );

      case DioExceptionType.badCertificate:
        throw NetworkException(
          message: 'Bad certificate',
          statusCode: err.response?.statusCode,
        );

      case DioExceptionType.unknown:
        throw NetworkException(
          message: 'Something went wrong. Please try again later.',
          statusCode: err.response?.statusCode,
        );
    }
  }
}

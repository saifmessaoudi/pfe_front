import 'package:dio/dio.dart';

import '../../../../core/config/constants/api_constants.dart';
import '../../../../core/config/http/dio_client.dart';
import '../../../../core/config/http/exceptions/api_exception.dart';
import '../../../../core/utils/logger/logger.dart';
import '../models/registration_request_model.dart';
import '../models/registration_response_model.dart';
import '../models/passkey_request_model.dart';
import '../models/passkey_response_model.dart';

abstract class RegistrationRemoteDataSource {
  Future<RegistrationResponseModel> initiateRegistration(RegistrationRequestModel request);
  Future<PasskeyResponseModel> completeRegistration(PasskeyRequestModel request);
}

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource {
  final DioClient _dioClient;

  RegistrationRemoteDataSourceImpl({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  @override
  Future<RegistrationResponseModel> initiateRegistration(RegistrationRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.registrationChallenge,
        data: request.toJson(),
      );
      LoggerService.d('Registration challenge response: ${response.data}');
      return RegistrationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.e('Failed to initiate registration: $e');
      throw ApiException(
        message: 'Failed to initiate registration',
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    } catch (e) {
      LoggerService.e('Unexpected error during registration initiation: $e');
      throw ApiException(
        message: 'Unexpected error during registration initiation',
      );
    }
  }

  @override
  Future<PasskeyResponseModel> completeRegistration(PasskeyRequestModel request) async {
    // Log the request details

    LoggerService.d('Completing registration with request: ${request.toJson()}');
    try {
      final response = await _dioClient.post(
        ApiConstants.completeRegistration,
        data: request.toJson(),
      );

      return PasskeyResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? 'Failed to complete registration',
        statusCode: e.response?.statusCode,
        data: e.response?.data,
      );
    } catch (e) {
      LoggerService.e('Unexpected error during registration completion: $e');
      throw ApiException(
        message: 'Unexpected error during registration completion',
      );
    }
  }
}

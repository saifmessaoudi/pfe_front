

import 'package:dio/dio.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_response_model.dart';

import '../../../../core/config/constants/api_constants.dart';
import '../../../../core/config/http/dio_client.dart';
import '../../../../core/config/http/exceptions/api_exception.dart';
import '../../../../core/utils/logger/logger.dart';
import '../models/complete_challenge_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginChallengeResponseModel> initiateLogin(LoginChallengeRequestModel request);
  Future<CompleteLoginChallengeResponseModel> completeLogin(CompleteChallengeRequestModel request);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient _dioClient;

  LoginRemoteDataSourceImpl({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();


  @override
  Future<LoginChallengeResponseModel> initiateLogin(LoginChallengeRequestModel request) async {
    try {
      final response = await _dioClient.post(
        '${ApiConstants.loginChallenge}?username=${request.username}',
      );
      return LoginChallengeResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      LoggerService.e('Failed to initiate login: $e');
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
  Future<CompleteLoginChallengeResponseModel> completeLogin(CompleteChallengeRequestModel request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.completeLogin,
        data: request.toJson(),
      );
      return CompleteLoginChallengeResponseModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        LoggerService.e('Failed to complete login challenge: ${e.message}');
        throw ApiException(
          message: 'Failed to complete login challenge',
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      }
      LoggerService.e('Unexpected error during login challenge completion: $e');
      throw ApiException(
        message: 'Unexpected error during login challenge completion',
      );

    }
  }


}
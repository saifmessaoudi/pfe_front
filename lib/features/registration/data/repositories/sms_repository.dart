// repositories/sms_repository.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/otp_entity.dart';
import '../../../../core/config/constants/api_constants.dart';
import '../../../../core/config/http/dio_client.dart';
import '../../../../core/config/http/exceptions/api_exception.dart';
import '../models/sms_entity.dart';

class SmsRepository {
  final DioClient _dioClient;
  SmsRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<bool> sendSms(SmsEntity smsEntity) async {
    try {
      final phoneNumberWithPrefix = '+216${smsEntity.phoneNumber}';
      final data = {
        "phone": phoneNumberWithPrefix,
      };

      final response = await _dioClient.post(
        ApiConstants.sendSms,
        data: json.encode(data),
      );

      if (response.statusCode == 409) {
        final errorMessage = response.data?['message'] ?? 'Phone number already registered';
        throw ApiException(
          message: errorMessage,
          statusCode: 409,
          data: response.data,
        );
      }

      return response.statusCode == 200;
    } on DioException catch( error) {
      LoggerService.e('Error sending SMS - Type: ${error.type} | Status: ${error.response?.statusCode}');
      // Extract the actual error message from the response if available
      final errorMessage = error.response?.data?['message'] ?? 'Failed to send SMS';

      throw ApiException(
        message: errorMessage,
        statusCode: error.response?.statusCode ?? 500,
        data: error.response?.data,
      );
    }

  }

  Future<bool> verifyOtp(OtpEntity otpEntity) async {
    try {
      final phoneNumberWithPrefix = '+216${otpEntity.phone}';
      final data = {
        "phone": phoneNumberWithPrefix,
        "otp": otpEntity.otp,
      };

      final response = await _dioClient.post(
        ApiConstants.verifyOtp,
        data: json.encode(data),
      );

      return response.statusCode == 200;
    } catch (error) {
      LoggerService.e('Error sending SMS: $error');
      return false;
    }

  }

}

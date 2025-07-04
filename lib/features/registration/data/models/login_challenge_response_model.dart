import 'package:mobile_authenticator_fido/features/registration/data/models/registration_response_model.dart';

class LoginChallengeResponseModel {
  final int statusCode;
  final String message;
  final ChallengeResponse response;

  LoginChallengeResponseModel({
    required this.statusCode,
    required this.message,
    required this.response,
  });

  factory LoginChallengeResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginChallengeResponseModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      response: ChallengeResponse.fromJson(json['response'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'response': response.toJson(),
    };
  }
}
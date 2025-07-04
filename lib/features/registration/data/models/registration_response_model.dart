class RegistrationResponseModel {
  final int statusCode;
  final String message;
  final ChallengeResponse response;

  RegistrationResponseModel({
    required this.statusCode,
    required this.message,
    required this.response,
  });

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
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

class ChallengeResponse {
  final String challenge;

  ChallengeResponse({required this.challenge});

  factory ChallengeResponse.fromJson(Map<String, dynamic> json) {
    return ChallengeResponse(
      challenge: json['challenge'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challenge': challenge,
    };
  }
}

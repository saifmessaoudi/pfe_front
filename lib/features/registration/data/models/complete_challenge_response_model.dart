class CompleteLoginChallengeResponseModel {
  final int statusCode;
  final String message;
  final Map<String, dynamic> response;  // Change to Map<String, dynamic> to handle complex response

  CompleteLoginChallengeResponseModel({
    required this.statusCode,
    required this.message,
    required this.response,
  });

  factory CompleteLoginChallengeResponseModel.fromJson(Map<String, dynamic> json) {
    return CompleteLoginChallengeResponseModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      response: json['response'] != null
          ? json['response'] as Map<String, dynamic>  // Change to handle Map<String, dynamic>
          : {},  // Default to an empty map if response is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'response': response,  // Ensure response is properly converted to JSON
    };
  }
}

import '../../data/models/registration_response_model.dart';

class RegistrationResponse {
  final int statusCode;
  final String message;
  final ChallengeResponse response;

  RegistrationResponse({
    required this.statusCode,
    required this.message,
    required this.response,
  });
}

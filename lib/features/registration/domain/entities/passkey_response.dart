import '../../data/models/passkey_response_model.dart';

class PasskeyResponse {
  final int? statusCode;
  final String? message;
  final UserRepresentationModel? response;

  PasskeyResponse({
    this.statusCode,
    this.message,
    this.response,
  });
}

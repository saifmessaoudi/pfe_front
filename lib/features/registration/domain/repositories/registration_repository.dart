import '../entities/passkey_request.dart';
import '../entities/passkey_response.dart';
import '../entities/registration_request.dart';
import '../entities/registration_response.dart';

abstract class RegistrationRepository {
  Future<RegistrationResponse> initiateRegistration(RegistrationRequest request);
  Future<PasskeyResponse> completeRegistration(PasskeyRequest request);
}

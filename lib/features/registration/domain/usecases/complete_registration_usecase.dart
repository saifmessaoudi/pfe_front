import '../entities/passkey_request.dart';
import '../entities/passkey_response.dart';
import '../repositories/registration_repository.dart';

class CompleteRegistrationUseCase {
  final RegistrationRepository _repository;

  CompleteRegistrationUseCase(this._repository);

  Future<PasskeyResponse> call(PasskeyRequest request) {
    return _repository.completeRegistration(request);
  }
}

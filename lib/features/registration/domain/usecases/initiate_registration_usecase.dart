import '../entities/registration_request.dart';
import '../entities/registration_response.dart';
import '../repositories/registration_repository.dart';

class InitiateRegistrationUseCase {
  final RegistrationRepository _repository;

  InitiateRegistrationUseCase(this._repository);

  Future<RegistrationResponse> call(RegistrationRequest request) {
    return _repository.initiateRegistration(request);
  }
}

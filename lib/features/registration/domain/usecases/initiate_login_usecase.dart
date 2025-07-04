
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_response_model.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/repositories/login_repository.dart';

class InitiateLoginChallengeUseCase {
  final LoginRepository _repository;

  InitiateLoginChallengeUseCase(this._repository);

  Future<LoginChallengeResponseModel> call(LoginChallengeRequestModel request) {
    return _repository.initiateLoginChallenge(request);
  }
}

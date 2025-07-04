

import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_response_model.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/repositories/login_repository.dart';

class CompleteLoginChallengeUseCase {
  final LoginRepository _repository;

  CompleteLoginChallengeUseCase(this._repository);

  Future<CompleteLoginChallengeResponseModel> call(CompleteChallengeRequestModel request) {
    return _repository.completeLoginChallenge(request);
  }
}

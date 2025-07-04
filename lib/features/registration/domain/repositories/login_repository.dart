import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_response_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_response_model.dart';

abstract class LoginRepository {
  Future<LoginChallengeResponseModel> initiateLoginChallenge(LoginChallengeRequestModel request);
  Future<CompleteLoginChallengeResponseModel> completeLoginChallenge(CompleteChallengeRequestModel request);
}

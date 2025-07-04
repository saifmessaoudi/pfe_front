import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/complete_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_request_model.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/login_challenge_response_model.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/repositories/login_repository.dart';

import '../../../../core/utils/logger/logger.dart';
import '../ds/login_remote_ds.dart';
import '../models/complete_challenge_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  LoginRepositoryImpl({LoginRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? Get.find<LoginRemoteDataSource>();


  @override
  Future<LoginChallengeResponseModel> initiateLoginChallenge(LoginChallengeRequestModel request) async {
    try {
      final requestModel = LoginChallengeRequestModel(
        username: request.username,
      );

      final responseModel = await _remoteDataSource.initiateLogin(requestModel);

      return LoginChallengeResponseModel(
          statusCode:  responseModel.statusCode,
          message: responseModel.message,
          response: responseModel.response
      );
    } catch (e) {
      LoggerService.e('Repository error during initiate registration: $e');
      rethrow;
    }
  }

  @override
  Future<CompleteLoginChallengeResponseModel> completeLoginChallenge(CompleteChallengeRequestModel request) {
    try {
      final responseModel = _remoteDataSource.completeLogin(request);
      return responseModel;
    } catch (e) {
      LoggerService.e('Repository error during complete login challenge: $e');
      rethrow;
    }
  }


}

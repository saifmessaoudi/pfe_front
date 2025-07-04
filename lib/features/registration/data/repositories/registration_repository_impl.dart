import 'package:get/get.dart';

import '../../../../core/utils/logger/logger.dart';

import '../../domain/entities/passkey_request.dart';
import '../../domain/entities/passkey_response.dart';
import '../../domain/entities/registration_request.dart';
import '../../domain/entities/registration_response.dart';
import '../../domain/repositories/registration_repository.dart';
import '../ds/registration_remote_ds.dart';
import '../models/registration_request_model.dart';
import '../models/passkey_request_model.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationRemoteDataSource _remoteDataSource;

  RegistrationRepositoryImpl({RegistrationRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? Get.find<RegistrationRemoteDataSource>();

  @override
  Future<RegistrationResponse> initiateRegistration(RegistrationRequest request) async {
    try {
      final requestModel = RegistrationRequestModel(
        username: request.username,
        email: request.email,
        firstName: request.firstName,
        lastName: request.lastName,
      );

      final responseModel = await _remoteDataSource.initiateRegistration(requestModel);

      return RegistrationResponse(
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
  Future<PasskeyResponse> completeRegistration(PasskeyRequest request) async {
    try {
      final requestModel = PasskeyRequestModel(
        jwtChallenge: request.jwtChallenge,
        signedJwtChallenge: request.signedJwtChallenge,
        publicKey: request.publicKey,
        deviceInfo: request.deviceInfo
      );

      final responseModel = await _remoteDataSource.completeRegistration(requestModel);

      return PasskeyResponse(
        statusCode: responseModel.statusCode,
        message: responseModel.message,
        response: responseModel.response,
      );
    } catch (e) {
      LoggerService.e('Repository error during complete registration: $e');
      rethrow;
    }
  }
}

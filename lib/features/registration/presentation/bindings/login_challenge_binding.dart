import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/utils/exception/ErrorHandler.dart';
import 'package:mobile_authenticator_fido/features/registration/data/ds/login_remote_ds.dart';
import 'package:mobile_authenticator_fido/features/registration/data/repositories/login_repository_impl.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/repositories/login_repository.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/usecases/complete_login_usecase.dart';
import 'package:mobile_authenticator_fido/features/registration/domain/usecases/initiate_login_usecase.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/login_challenge_controller.dart';

import '../utils/biometric_service.dart';
import '../utils/crypto_service.dart';
import '../utils/secure_storage.dart';



class LoginChallengeBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure data sources and repositories are registered
    if (!Get.isRegistered<LoginRemoteDataSource>()) {
      Get.lazyPut<LoginRemoteDataSource>(
            () => LoginRemoteDataSourceImpl(),
      );
    }

    if (!Get.isRegistered<LoginRepository>()) {
      Get.lazyPut<LoginRepository>(
            () => LoginRepositoryImpl(),
      );
    }

    // Use cases
    Get.lazyPut(
          () => InitiateLoginChallengeUseCase(Get.find<LoginRepository>()),
    );
    Get.lazyPut(
          () => CompleteLoginChallengeUseCase(Get.find<LoginRepository>()),
    );

    Get.lazyPut(
          () => CryptoService(),
    );

    Get.lazyPut(
          () => ErrorHandlerService(),
    );

    Get.lazyPut(
          () => BiometricService(),
    );
    Get.lazyPut(() => SecureStorageService(const FlutterSecureStorage()));


    Get.lazyPut<LoginChallengeController>(() => LoginChallengeController(
      initiateUseCase: Get.find(),
      completeUseCase: Get.find(),
      cryptoService: Get.find(),
      biometricService: Get.find(),
    ));

  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/secure_storage.dart';
import '../../data/ds/registration_remote_ds.dart';
import '../../data/repositories/registration_repository_impl.dart';
import '../../domain/repositories/registration_repository.dart';
import '../../domain/usecases/complete_registration_usecase.dart';
import '../controllers/passkey_controller.dart';
import '../utils/biometric_service.dart';
import '../utils/crypto_service.dart';

class PasskeyBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure data sources and repositories are registered
    if (!Get.isRegistered<RegistrationRemoteDataSource>()) {
      Get.lazyPut<RegistrationRemoteDataSource>(
            () => RegistrationRemoteDataSourceImpl(),
      );
    }

    if (!Get.isRegistered<RegistrationRepository>()) {
      Get.lazyPut<RegistrationRepository>(
            () => RegistrationRepositoryImpl(),
      );
    }

    // Use cases
    Get.lazyPut(
          () => CompleteRegistrationUseCase(Get.find<RegistrationRepository>()),
    );

    // Services
    Get.lazyPut(
          () => CryptoService(),
    );

    Get.lazyPut(
          () => BiometricService(),
    );
    Get.lazyPut(
          () => SecureStorageService(const FlutterSecureStorage()),
    );


    // Controllers
    Get.lazyPut(
          () => PasskeyController(
        completeRegistrationUseCase: Get.find(),
        cryptoService: Get.find(),
        biometricService: Get.find(),
      ),
    );
  }
}

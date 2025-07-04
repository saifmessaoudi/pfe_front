import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/welcome_controller.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/biometric_service.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/secure_storage.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => BiometricService(),
    );

    Get.lazyPut(
          () => SecureStorageService(const FlutterSecureStorage()),
    );

    // Controller
    Get.lazyPut(
          () => WelcomeController(
        biometricService: Get.find(),
      ),
    );
  }

}
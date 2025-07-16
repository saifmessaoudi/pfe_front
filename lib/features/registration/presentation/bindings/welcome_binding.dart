import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/welcome_controller.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/biometric_service.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/local_auth_service.dart';

import '../utils/secure_storage_mig.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiometricService());

    Get.lazyPut(() => SecureStorageServiceMig());

    // Controller
    Get.lazyPut(() => WelcomeController(biometricService: Get.find()));

    // Controller
    Get.lazyPut(() => LocalAuthService());
  }
}

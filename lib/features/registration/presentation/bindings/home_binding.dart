import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/secure_storage.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => SecureStorageService(const FlutterSecureStorage()),
    );

    Get.lazyPut<HomeController>(() => HomeController());
  }
}

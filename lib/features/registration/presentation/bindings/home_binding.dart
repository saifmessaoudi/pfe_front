import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../utils/secure_storage_mig.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SecureStorageServiceMig());

    Get.lazyPut<HomeController>(() => HomeController());
  }
}

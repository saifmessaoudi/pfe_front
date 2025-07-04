import 'package:get/get.dart';
import '../controllers/root_controller.dart';
import '../controllers/home_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => HomeController());
  }
}

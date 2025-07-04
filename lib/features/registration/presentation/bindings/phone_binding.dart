import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/phone_controller.dart';

import '../../data/repositories/sms_repository.dart';
import '../../domain/usecases/SendSmsUseCase.dart';


class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SmsRepository());
    Get.lazyPut(() => SendSmsUseCase(Get.find<SmsRepository>()));
    Get.lazyPut(() => PhoneController(
      Get.find<SendSmsUseCase>(),
    ));


  }
}

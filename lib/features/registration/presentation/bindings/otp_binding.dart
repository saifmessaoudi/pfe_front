import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/otp_controller.dart';

import '../../data/repositories/sms_repository.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SmsRepository());
    Get.lazyPut<OtpController>(() => OtpController());
  }
}

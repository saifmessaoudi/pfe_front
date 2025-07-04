import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/config/routing/app_routes.dart';
import 'package:mobile_authenticator_fido/features/registration/data/models/otp_entity.dart';
import 'package:mobile_authenticator_fido/features/registration/data/repositories/sms_repository.dart';

class OtpController extends GetxController {
  final code = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final maskedPhoneNumber = ''.obs;
  final canResend = false.obs;
  final resendCountdown = 0.obs;
  final resendSecondsStr = '00'.obs;
  final FocusNode focusNode = FocusNode();
  final TextEditingController codeController = TextEditingController();

  late final String phoneNumber = Get.arguments['phoneNumber'] as String;

  final SmsRepository smsRepository = Get.find<SmsRepository>();


  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    startResendCountdown();
    maskedPhoneNumber.value = _maskPhoneNumber(phoneNumber);

    codeController.addListener(() {
      if (codeController.text.length <= 6) {
        code.value = codeController.text;
      }
    });
  }

  String _maskPhoneNumber(String phone) {
    if (phone.length < 6) return phone; // safety check

    final firstTwo = phone.substring(0, 2);
    final lastThree = phone.substring(phone.length - 3);
    return '$firstTwo***$lastThree';
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    codeController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void onCodeChanged(String value) {
    if (value.length <= 6) {
      code.value = value;
    }
  }

  Future<void> validateCode() async {
    if (code.value.length != 6) return;
    final cleanedPhoneNumber =  phoneNumber.replaceAll(' ', '');

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final smsEntity = OtpEntity(
        phone:  cleanedPhoneNumber,
        otp:  code.value,
      );
      final response =  await smsRepository.verifyOtp(smsEntity);
      if (response) {
        Get.offAllNamed(AppRoutes.REGISTRATION,arguments: {'phoneNumber': cleanedPhoneNumber});
      } else {
        errorMessage.value = 'Code invalide ou expiré.';
      }
    } catch (e) {
      errorMessage.value = 'Erreur de validation du code.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendCode() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      code.value = '';
      codeController.clear();
      startResendCountdown();

    } catch (e) {
      errorMessage.value = 'Erreur lors de l’envoi du code.';
    } finally {
      isLoading.value = false;
    }
  }

  void startResendCountdown() {
    canResend.value = false;
    resendCountdown.value = 1;
    resendSecondsStr.value = '00';

    const oneSecond = Duration(seconds: 1);
    int totalSeconds = 60;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(oneSecond, (timer) {
      totalSeconds--;

      if (totalSeconds <= 0) {
        timer.cancel();
        canResend.value = true;
        resendCountdown.value = 0;
        resendSecondsStr.value = '00';
      } else {
        resendCountdown.value = totalSeconds ~/ 60;
        int seconds = totalSeconds % 60;
        resendSecondsStr.value = seconds < 10 ? '0$seconds' : '$seconds';
      }
    });
  }
}

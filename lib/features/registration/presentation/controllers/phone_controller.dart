
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/http/exceptions/api_exception.dart';
import '../../../../core/config/routing/app_routes.dart';
import '../../../../core/utils/logger/logger.dart';
import '../../data/models/sms_entity.dart';
import '../../domain/usecases/SendSmsUseCase.dart';


class PhoneController extends GetxController {

  final SendSmsUseCase sendSmsUseCase;
  PhoneController( this.sendSmsUseCase);

  // Text controllers
  final phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // Observable variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final errorMessage = ''.obs;
  var phoneNumber = ''.obs;


    @override
    void onInit() {
      super.onInit();
      phoneController.addListener(() {
        phoneNumber.value = phoneController.text;
      });
    }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  bool isPhoneValid(String text) {
    // Remove all non-digit chars and check length
    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 8;
  }

  // Handle forgot password
  Future<void> sendSms() async {
    final cleanedPhoneNumber = phoneNumber.value.replaceAll(' ', '');

    if (!isPhoneValid(phoneNumber.value)) {
      errorMessage.value = 'Numéro de téléphone invalide.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await sendSmsUseCase.execute(SmsEntity(phoneNumber: cleanedPhoneNumber));

      if (success) {
        Get.toNamed(AppRoutes.OTP, arguments: {'phoneNumber': phoneNumber.value});
      }
    } on ApiException catch (e) {
      LoggerService.e('API Error - Status: ${e.statusCode} | Message: ${e.message} | Data: ${e.data}');
      // Handle specific status codes
      switch (e.statusCode) {
        case 409:
          errorMessage.value = 'Ce numéro est déjà enregistré. Veuillez vous connecter.';
          Get.toNamed(
            '/login-challenge',
            arguments: {
              'username': cleanedPhoneNumber,
              'isExistingUser': true,
            } );
          break;
        case 400:
          errorMessage.value = 'Requête invalide. Veuillez vérifier les données.';
          break;
        case 500:
          errorMessage.value = 'Erreur serveur. Veuillez réessayer plus tard.';
          break;
        default:
          errorMessage.value = e.message ?? 'Échec de l\'envoi du SMS. Veuillez réessayer.';
      }
    } catch (e) {
      LoggerService.e('Unexpected Error: $e');
      errorMessage.value = 'Une erreur inattendue est survenue.';
    } finally {
      isLoading.value = false;
    }
  }
}

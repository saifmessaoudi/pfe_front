import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/http/exceptions/api_exception.dart';
import '../../../../core/config/http/exceptions/network_exception.dart';
import '../../../../core/config/routing/app_routes.dart';
import '../../../../core/utils/logger/logger.dart';
import '../../domain/entities/registration_request.dart';
import '../../domain/usecases/initiate_registration_usecase.dart';

class RegistrationController extends GetxController {
  final InitiateRegistrationUseCase _initiateRegistrationUseCase;

  RegistrationController({
    required InitiateRegistrationUseCase initiateRegistrationUseCase,
  }) : _initiateRegistrationUseCase = initiateRegistrationUseCase;

  // Form controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Loading state
  final RxBool isLoading = false.obs;

  // Error state
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController.value = TextEditingValue(text: Get.arguments['phoneNumber'] as String);
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  // Validate username
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Submit registration form
  Future<void> submitRegistration() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = RegistrationRequest(
        username: usernameController.text,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      );

      final response = await _initiateRegistrationUseCase(request);

      // Navigate to passkey screen with challenge
      Get.toNamed(
        AppRoutes.PASSKEY,
        arguments:
        {'challenge': response.response.challenge
          , 'username': request.username},
      );
    } on ApiException catch (e) {
      LoggerService.e('API error during registration: $e');
      errorMessage.value = e.message;
    } on NetworkException catch (e) {
      LoggerService.e('Network error during registration: $e');
      errorMessage.value = e.message;
    } catch (e) {
      LoggerService.e('Unexpected error during registration: $e');
      errorMessage.value = 'An unexpected error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}

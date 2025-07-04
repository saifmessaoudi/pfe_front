import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/constants/app_constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/registration_controller.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children:[
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              'assets/texture.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Bienvenue dans l\'application',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Créez votre compte pour commencer',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Username field
                  CustomTextField(
                    controller: controller.usernameController,
                    label: 'Nom d\'utilisateur',
                    prefixIcon: const Icon(Icons.person_outline ),
                    validator: controller.validateUsername,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  // Email field
                  CustomTextField(
                    controller: controller.emailController,
                    label: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  // First name field
                  CustomTextField(
                    controller: controller.firstNameController,
                    label: 'Prénom',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    validator: controller.validateName,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  // Last name field
                  CustomTextField(
                    controller: controller.lastNameController,
                    label: 'Nom',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    validator: controller.validateName,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  // Error message
                  Obx(() => controller.errorMessage.value.isNotEmpty
                      ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                    ),
                    child: Text(
                      controller.errorMessage.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                  ),
                  // Submit button
                  Obx(() => CustomButton(
                    borderRadius: 30,
                    backgroundColor: Color(0xFFEBAC1D),
                    text: 'Continuer',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submitRegistration,
                  )),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),],
      ),
    );
  }
}

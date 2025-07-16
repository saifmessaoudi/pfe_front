import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/phone_controller.dart';
import '../../../../core/widgets/custom_button.dart';
import '../utils/phoneNumberFormatter.dart';

class PhoneScreen extends GetView<PhoneController> {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),

                    const Text(
                      'Bienvenue !',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Cher(e) utilisateur, pour continuer, veuillez entrer votre numéro de téléphone. Nous vous enverrons un code de vérification.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 45),

                    const Text(
                      'NUMÉRO DE TÉLÉPHONE PERSONNELLE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Custom phone input
                    Obx(() {
                      final isValid = controller.phoneNumber.value.isNotEmpty;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all
                              (color: isValid ? const Color(0xFFEBAC1D) : Colors.grey,
                                width: 1),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                '🇹🇳 +216',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: TextField(
                                  controller: controller.phoneController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    PhoneNumberFormatter(),
                                  ],
                                  style:  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withValues(alpha:0.8),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  cursorColor: const Color(0xFFEBAC1D),
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    counterText: '',
                                    hintText: 'Numéro de téléphone',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 30),
                    Obx(() {
                      final isValid = controller.phoneNumber.value.length == 10;
                      return CustomButton(
                        height: 50,
                        width: double.infinity,
                        borderRadius: 30,
                        isLoading: controller.isLoading.value,
                        text: "Suivant",
                        backgroundColor: const Color(0xFFEBAC1D),
                        onPressed:
                            controller.isLoading.value || !isValid
                                ? null
                                : controller.sendSms,
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.errorMessage.value.isNotEmpty) {
                        return Center(
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

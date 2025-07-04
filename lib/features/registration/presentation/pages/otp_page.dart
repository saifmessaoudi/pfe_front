import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/otp_controller.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/widgets/custom_button.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset('assets/logo.png', width: 120, height: 120),
                    const SizedBox(height: 50),
                    const Text(
                      'Vérification de votre numéro de téléphone',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Un code de vérification à usage unique vous a été envoyé par SMS. Veuillez entrer ce code pour sécuriser votre compte.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 70),
                    Text(
                      'UN CODE A ÉTÉ ENVOYÉ À ${controller.maskedPhoneNumber.value}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // OTP input
                    Pinput(
                      focusNode: controller.focusNode,
                      onTapOutside: (_) => controller.focusNode.unfocus(),

                      preFilledWidget: const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                      ),
                      length: 6,
                      controller: controller.codeController,
                      onCompleted: (value) {

                      },
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle:  TextStyle(
                          fontSize: 20,
                          color: Color(0xFFEBAC1D).withValues(alpha:0.9),
                        ),

                      ),
                      focusedPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFFEBAC1D),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFEBAC1D)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Resend button
                    Obx(
                      () => TextButton(
                        onPressed:
                            controller.canResend.value
                                ? controller.resendCode
                                : null,
                        child: Text(
                          controller.canResend.value
                              ? 'Renvoyer le code'
                              : 'Renvoyer le code dans ${controller.resendCountdown.value}:${controller.resendSecondsStr.value}',
                          style:  TextStyle(color: controller.canResend.value
                              ? const Color(0xFFEBAC1D)
                              : Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Submit button
                    Obx(

                      (){
                        final isValid = controller.code.value.length == 6;
                        return  CustomButton(
                          width: double.infinity,
                          height: 50,
                          borderRadius: 30,
                          isLoading: controller.isLoading.value,
                          backgroundColor:
                               const Color(0xFFEBAC1D),
                          text:
                              'Vérifier le code',
                          onPressed: controller.isLoading.value || !isValid
                              ? null
                              : controller.validateCode,
                      );}
                    ),
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

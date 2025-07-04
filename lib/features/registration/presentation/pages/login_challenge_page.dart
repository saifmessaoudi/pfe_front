import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/controllers/login_challenge_controller.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LoginChallengeScreen extends GetView<LoginChallengeController> {
  const LoginChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient or texture if needed

          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/texture.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // back button
                   const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.blueGrey),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Bienvenue dans ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'MyApp',
                          style: TextStyle(
                            color: Color(0xFFEBAC1D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Utilisez votre biométrie pour vous connecter',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                  ),
                  const Spacer(),

                  Obx(() {
                  return controller.errorMessage.isNotEmpty
                      ? Text(
                          controller.errorMessage.value,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                        ) : const SizedBox.shrink();
                  }),
                  const SizedBox(height: 25),
                  Obx(() {
                    return controller.isLoading.value
                        ?  const CircularProgressIndicator(color: Color(0xFFEBAC1D))
                        : GestureDetector(
                      onTap: controller.initiateLoginChallenge,
                        child:  SvgPicture.asset(
                          'assets/fingerprint.svg',
                          width: 70,
                          height: 70,
                        ),

                    );
                  }),

                  const SizedBox(height: 40),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

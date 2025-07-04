import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
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
          child: Column(
            children: [
              const SizedBox(height: 75),
              Center(
                child: Column(
                  children: [
                    // App icon
                    Image.asset(
                      'assets/logo.png',
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 33),
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
                    const SizedBox(height: 8),
                    const Text(
                      'Utilisez votre biométrie pour vous connecter',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Obx(() {
                  return Column(
                    children: [
                      if (!controller.isAuthenticated.value)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: controller.onRegisterPressed,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Color(0xFFEBAC1D)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Créer un compte',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFEBAC1D),
                              ),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Color(0xFFEBAC1D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.fingerprint,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Connexion avec la biométrie",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: controller.onBiometricPressed,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: const BorderSide(color: Color(0xFFEBAC1D)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.lock,
                                  size: 22,
                                  color: Color(0xFFEBAC1D),
                                ),
                                onPressed: controller.onBiometricPressed,
                                label: const Text(
                                  "Connexion avec Passcode",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFEBAC1D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 40),
                    ],
                  );
                }),
              ),

            ],
          ),
        ),
    ]
      ),
    );
  }
}

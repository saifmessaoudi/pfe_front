import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/texture.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified_user, size: 80, color: Color(0xFFEBAC1D)),
                const SizedBox(height: 20),
                const Text(
                  'Authentification réussie ! 🎉',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Obx(() => Text(
                  'Bienvenue, ${controller.username.value}!',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                )),
              ],
            ),
          ),
        ),
    ],
      ),
    );
  }
}

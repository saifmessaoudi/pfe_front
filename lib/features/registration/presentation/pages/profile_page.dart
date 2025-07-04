import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/utils/manager/SessionManager.dart';
import '../controllers/home_controller.dart';import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends GetView<HomeController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchUserProfile();

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3, // Adjust opacity to make the background subtle
            child: Image.asset(
              'assets/texture.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                final profile = controller.userProfile.value;
                if (profile == null) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFEBAC1D)));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture and Name
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xFFEBAC1D),
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      profile.preferredUsername ?? 'No username',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.emailVerified
                          ? 'Utilisateur vérifié via biométrie'
                          : 'Utilisateur non vérifié',
                      style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.blueGrey, thickness: 1),

                    // User Profile Options
                    _buildProfileOption(Icons.account_box, 'User Profile', () {}),
                    _buildProfileOption(Icons.lock, 'Change Password', () {}),
                    _buildProfileOption(Icons.question_answer, 'FAQs', () {}),
                    _buildNotificationOption(),

                    const SizedBox(height: 30),
                    // Credentials Section
                    Text(
                      'Vos PassKeys',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Display Credentials
                    ...profile.credentials.map((cred) => ListTile(
                      title: Text('Device: ${cred.deviceName ?? "N/A"}', style: const TextStyle(color: Colors.blueGrey)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Device Model: ${cred.deviceModel ?? "N/A"}', style: const TextStyle(color: Colors.blueGrey)),
                          Text('Created: ${DateTime.fromMillisecondsSinceEpoch(cred.createdDate).toLocal().toString().split(' ')[0]}',
                              style: const TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward, color: Colors.blueGrey),
                    )),
                    const SizedBox(height: 20),
                    // Logout Button
                    _buildLogoutOption(),

                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLogoutOption() {
    return ListTile(
      onTap: () async {
        // Call your logout method here
        await SessionManager().logout();
        // Navigate to the welcome screen or login screen after logout
        Get.offAllNamed('/welcome'); // Replace '/welcome' with the appropriate route
      },
      leading: const Icon(Icons.logout, color: Colors.blueGrey),
      title: const Text('Logout', style: TextStyle(color: Colors.blueGrey)),
    );
  }
  Widget _buildProfileOption(IconData icon, String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: const TextStyle(color: Colors.blueGrey)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
    );
  }

  Widget _buildNotificationOption() {
    return ListTile(
      leading: const Icon(Icons.notifications, color: Colors.blueGrey),
      title: const Text('Push Notification', style: TextStyle(color: Colors.blueGrey)),
      trailing: Switch(
        value: true, // Assuming user enabled for demonstration
        onChanged: (bool value) {
          // Add functionality for switching push notifications here
        },
        activeColor: const Color(0xFFEBAC1D),
      ),
    );
  }
}

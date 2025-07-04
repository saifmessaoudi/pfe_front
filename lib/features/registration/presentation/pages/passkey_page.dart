import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/constants/app_constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/passkey_controller.dart';

class PasskeyPage extends GetView<PasskeyController> {
  const PasskeyPage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.fingerprint,
                  size: 100,
                  color:  Color(0xFFEBAC1D),
                ),
                const SizedBox(height: 32),
                Text(
                  controller.isSuccess.value
                      ? 'Passkey créé avec succès'
                      : 'Création de Passkey',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.isSuccess.value
                      ? 'Votre Passkey a été créé avec succès. Vous pouvez maintenant vous connecter à votre compte.'
                      : 'Veillez attendre pendant que nous créons votre Passkey. Cela peut prendre quelques secondes..',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.70),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Error message
                if (controller.errorMessage.value.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
                    ),
                    child: Text(
                      controller.errorMessage.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Loading indicator or success icon
                if (controller.isLoading.value)
                  const CircularProgressIndicator(color: Color(0xFFEBAC1D),),
                if (controller.isSuccess.value && !controller.isLoading.value)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                const SizedBox(height: 32),

                // Retry button if there's an error
                if (!controller.isLoading.value &&
                    !controller.isSuccess.value &&
                    controller.errorMessage.value.isNotEmpty)
                  CustomButton(
                    borderRadius: 30,
                    backgroundColor: Color(0xFFEBAC1D),
                    text: 'Réessayer',
                    onPressed: (){controller.createPasskey(controller.username);},
                  ),
              ],
            )),
          ),
        ),],
      ),
    );
  }
}

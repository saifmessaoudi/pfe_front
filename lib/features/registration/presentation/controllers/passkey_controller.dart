import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/core/config/routing/app_routes.dart';

import '../../../../core/utils/logger/logger.dart';
import '../../domain/entities/device_info.dart';
import '../../domain/entities/passkey_request.dart';
import '../../domain/usecases/complete_registration_usecase.dart';
import '../utils/biometric_service.dart';
import '../utils/crypto_service.dart';
import '../utils/secure_storage_mig.dart';

class PasskeyController extends GetxController {
  final CompleteRegistrationUseCase _completeRegistrationUseCase;
  final CryptoService _cryptoService;
  final BiometricService _biometricService;
  final SecureStorageServiceMig _secureStorageService = Get.find();

  PasskeyController({
    required CompleteRegistrationUseCase completeRegistrationUseCase,
    required CryptoService cryptoService,
    required BiometricService biometricService,
  }) : _completeRegistrationUseCase = completeRegistrationUseCase,
       _cryptoService = cryptoService,
       _biometricService = biometricService;

  late String challenge;
  late String username;

  final RxBool isLoading = false.obs;
  final RxBool isSuccess = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      challenge = args['challenge'] as String;
      username = args['username'] as String? ?? '';
    }

    if (challenge.isEmpty) {
      errorMessage.value = 'Aucun challenge fourni.';
      isLoading.value = false;
      return;
    }

    // create passkey
   // createPasskey(username);
  }

  void createPasskeyWithUsername() {
    createPasskey(username);
  }

  Future<void> createPasskey(String username) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final canUseBiometric = await _biometricService.canAuthenticate();
      if (!canUseBiometric) {
        errorMessage.value = 'L’authentification biométrique est requise.';
        return;
      }

      final keyPair = await _cryptoService.generatePemKeyPair();

      await _secureStorageService.writeUsername(username);

      final biometricSuccess = await _biometricService.writePrivateKey(
        username,
        keyPair.privateKeyPem,
      );
      if (!biometricSuccess) {
        errorMessage.value = 'Échec de l\'enregistrement de la clé privée.';
        LoggerService.d('Échec de l\'enregistrement de la clé privée. == true');

        return;
      } else {
        LoggerService.d('Échec de l\'enregistrement de la clé privée. == False');

      }

      final signedChallenge = _cryptoService.signWithPem(
        challenge,
        keyPair.privateKeyPem,
      );
      final publicKey = keyPair.publicKeyPem;

      // Collect device information
      final deviceInfos = await collectDeviceInfo();

      final request = PasskeyRequest(
        jwtChallenge: challenge,
        signedJwtChallenge: signedChallenge,
        publicKey: publicKey,
        deviceInfo: deviceInfos,
      );

      final response = await _completeRegistrationUseCase(request);

      if (response.statusCode == 201) {
        isSuccess.value = true;
        LoggerService.d(response.message!);
        await _secureStorageService.setIsAuthenticated(true);
        await _secureStorageService.writeUsername(username);
        LoggerService.d('Passkey created successfully for user: $username');
        Get.offAllNamed(AppRoutes.WELCOME);
      } else if (response.statusCode == 409) {
        errorMessage.value = 'Utilisateur déjà enregistré';
      } else if (response.statusCode == 400) {
        errorMessage.value = 'Votre demande de création de compte a échoué';
      } else if (response.statusCode == 500) {
        errorMessage.value = 'Erreur interne du serveur';
      } else if (response.statusCode == 401) {
        errorMessage.value = 'Demande échouée';
      } else if (response.statusCode == 403) {
        errorMessage.value = 'Accès refusé';
      } else {
        errorMessage.value = response.message!;
      }
    } on Exception catch (e) {
      if (e.toString() == 'Exception: SECURE_LOCK_SCREEN_REQUIRED') {
        LoggerService.e('Secure lock screen required: $e');
        errorMessage.value =
            'Veuillez configurer un écran de verrouillage sécurisé sur votre appareil.';
        Get.bottomSheet(
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, size: 100, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Veuillez configurer un écran de verrouillage sécurisé sur votre appareil et réessayer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          isScrollControlled: true,
        );
      } else {
        LoggerService.e('Unexpected error during passkey creation: $e');
        errorMessage.value =
            'Une erreur inattendue s\'est produite. Veuillez réessayer.';
      }
    } finally {
      isLoading.value = false;
    }
  }
}

// Collect device information
Future<DeviceInfoModel> collectDeviceInfo() async {
  if (Platform.isIOS) {
    return DeviceInfoModel(
      deviceUUID: "1234",
      deviceName: "Iphone",
      deviceModel: "Iphone X",
    );
  }
  final deviceInfoPlugin = DeviceInfoPlugin();
  final androidPlugin = AndroidId();

  final androidInfo = await deviceInfoPlugin.androidInfo;
  final androidId = await androidPlugin.getId() ?? '';

  return DeviceInfoModel(
    deviceUUID: androidId,
    deviceName: androidInfo.model,
    deviceModel: androidInfo.manufacturer,
  );
}

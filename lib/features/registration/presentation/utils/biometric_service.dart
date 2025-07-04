import 'package:biometric_storage/biometric_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';

import 'local_auth_service.dart';

class BiometricService {

  final localAuthService = LocalAuthService();


  Future<bool> canAuthenticate() async {
    final response = await BiometricStorage().canAuthenticate();
    return response == CanAuthenticateResponse.success;
  }

  Future<List<BiometricType>> isBiometricAvailable() async {
    return localAuthService.getAvailableBiometrics();
  }



  Future<BiometricStorageFile?> getBiometricFile(String username) async {
    final canAuth = await canAuthenticate();
    if (!canAuth) return null;
    LoggerService.d(await localAuthService.getAvailableBiometrics());
    final method = await localAuthService.getPreferredBiometricMethod();
    final title = switch (method) {
      'face' => 'Utilisez la reconnaissance faciale',
      'fingerprint' => 'Utilisez votre empreinte digitale',
      'iris' => 'Utilisez la reconnaissance d’iris',
      _ => 'Authentification biométrique',
    };

    return BiometricStorage().getStorage(
      promptInfo: PromptInfo(
        androidPromptInfo: AndroidPromptInfo(
          title: title,
          subtitle: 'Vérification d\'identité requise',
          negativeButton: 'Annuler',
          confirmationRequired: false
        ),
      ),
      'passkey_private_$username',
      options: StorageFileInitOptions(
        authenticationRequired: true,
        authenticationValidityDurationSeconds: 5,
      ),
    );
  }

  Future<bool> writePrivateKey(String username,String privateKeyPem) async {
    LoggerService.d('Writing private key for username: $username');
    try {
      final file = await getBiometricFile(username);
      if (file == null) {
        LoggerService.e('❌ Biometric file is null');
        return false;
      }

      await file.write(privateKeyPem);
      //await saveUsername(username);
      return true;
    } catch (e,stack) {
      LoggerService.e('❌ Exception while writing private key: $e\n$stack');
      if (e.toString().contains('Secure lock screen must be enabled')) {
        throw Exception('SECURE_LOCK_SCREEN_REQUIRED');
      }
      return false;
    }
  }



  Future<String?> readPrivateKey(String username) async {
    try {
      final file = await getBiometricFile(username);
      if (file == null) return null;
      final privateKey = await file.read();
      return privateKey;
    }  catch (e) {
      if (e is AuthException && e.code == AuthExceptionCode.userCanceled) {
        // Handle user cancellation
        LoggerService.e('User canceled the biometric authentication');
        rethrow;  // Propagate the error
      } else {
        LoggerService.e('Error reading private key: $e');
        rethrow;  // Propagate any other errors
      }
    }
  }

  //save and read username only
  Future<bool> saveUsername(String username) async {
    try {
      final file = await BiometricStorage().getStorage(
        promptInfo: PromptInfo(
          androidPromptInfo: AndroidPromptInfo(
            title: 'Vérification d\'identité',
            subtitle: 'Entrez votre empreinte digitale',
            negativeButton: 'Annuler',
          ),
        ),
        'passkey_username',
        options: StorageFileInitOptions(
          authenticationRequired: true,
          authenticationValidityDurationSeconds: 5,
        ),
      );
      await file.write(username);
      return true;
    } catch (e) {
      LoggerService.e('❌ Error saving username: $e');
      return false;
    }
  }

  Future<String?> readUsername() async {
    try {
      final file = await BiometricStorage().getStorage(
        promptInfo: PromptInfo(
          androidPromptInfo: AndroidPromptInfo(
            title: 'Vérification d\'identité',
            subtitle: 'Entrez votre empreinte digitale',
            negativeButton: 'Annuler',
          ),
        ),
        'passkey_username',
        options: StorageFileInitOptions(
          authenticationRequired: false,
          authenticationValidityDurationSeconds: 5,
        ),
      );
      final username = await file.read();
      LoggerService .d('Username read successfully from biometric : $username');
      return username;
    } catch (e) {
      LoggerService.e('❌ Error reading username: $e');
      return null;
    }
  }
}

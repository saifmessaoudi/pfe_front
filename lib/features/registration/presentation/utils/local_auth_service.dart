
import 'dart:io';

import 'package:local_auth/local_auth.dart';

import '../../../../core/utils/logger/logger.dart';

class LocalAuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final availableBiometrics = await auth.getAvailableBiometrics();
      showBiometricTypes(availableBiometrics);
      return availableBiometrics;
    } catch (e) {
      LoggerService.e('Error getting available biometrics: $e');
      return [];
    }
  }

  void showBiometricTypes(List<BiometricType> availableBiometrics) {
    for (final type in availableBiometrics) {
      switch (type) {
        case BiometricType.strong:
          if (Platform.isIOS) {
            LoggerService.d('Face ID (strong) is available');
          } else if (Platform.isAndroid) {
            LoggerService.d('Fingerprint (strong) is available');
          } else {
            LoggerService.d('Strong biometric available (unknown platform)');
          }
          break;

        case BiometricType.weak:
          if (Platform.isAndroid) {
            LoggerService.d('Fingerprint (weak) is available');
          } else {
            LoggerService.d('Weak biometric available');
          }
          break;

        case BiometricType.iris:
          LoggerService.d('Iris recognition is available');
          break;

        default:
          LoggerService.d('Unknown biometric type: $type');
          break;
      }
    }
  }




  Future<String> getPreferredBiometricMethod() async {
    final available = await getAvailableBiometrics();

    if (available.contains(BiometricType.face)) return 'face';
    if (available.contains(BiometricType.fingerprint)) return 'fingerprint';
    if (available.contains(BiometricType.iris)) return 'iris';
    return 'none';
  }
}

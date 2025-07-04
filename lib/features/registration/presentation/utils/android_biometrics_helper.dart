import 'package:flutter/services.dart';

class AndroidBiometricHelper {
  static const MethodChannel _channel = MethodChannel('biometric_info_android');

  static Future<List<String>> getAvailableBiometricTypes() async {
    final List<dynamic> types = await _channel.invokeMethod('getBiometricTypes');
    return types.map((e) => e.toString()).toList();
  }
}

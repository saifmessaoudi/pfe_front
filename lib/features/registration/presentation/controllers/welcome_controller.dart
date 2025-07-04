import 'package:get/get.dart';
import '../../../../core/utils/logger/logger.dart';
import '../utils/android_biometrics_helper.dart';
import '../utils/biometric_service.dart';
import '../utils/secure_storage.dart';

class WelcomeController extends GetxController {

  final BiometricService _biometricService;
  final SecureStorageService _secureStorageService = Get.find();

  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  WelcomeController({
    required BiometricService biometricService,
  }) : _biometricService = biometricService;

  //init
  @override
  void onInit() async{
    super.onInit();
  //secure storage
    isAuthenticated.value =  await _secureStorageService.getIsAuthenticated();
    // Check if biometric authentication is available
    final types = await AndroidBiometricHelper.getAvailableBiometricTypes();
    for (var type in types) {
      LoggerService.i('Available biometric type: $type');
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Check if biometric authentication is available
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    isAuthenticated.value = await _secureStorageService.getIsAuthenticated();
  }



  void onBiometricPressed() {
    // Replace with actual biometric login navigation
    Get.toNamed('/login-challenge', arguments: {
      'username': _secureStorageService.readUsername(),
    });

  }

  void onRegisterPressed() {
    // Navigate to registration screen
    Get.toNamed('/phone');
  }

  void onPasscodePressed() {
    // Navigate to passcode screen
    Get.toNamed('/registration');
  }

}

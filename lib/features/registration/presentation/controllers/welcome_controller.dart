import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/utils/local_auth_service.dart';
import '../utils/biometric_service.dart';
import '../utils/secure_storage_mig.dart';

class WelcomeController extends GetxController {
  final BiometricService _biometricService;
  final LocalAuthService _localAuthService = LocalAuthService();
  final SecureStorageServiceMig _secureStorageService = Get.find();

  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  WelcomeController({required BiometricService biometricService})
    : _biometricService = biometricService;

  //init
  @override
  void onInit() async {
    super.onInit();
/*     await _localAuthService.getAvailableBiometrics();
    await _biometricService.getBiometricFile("user_test");*/
    //secure storage
    isAuthenticated.value = await _secureStorageService.getIsAuthenticated();
    // Check if biometric authentication is available
/*    final types = await.getAvailableBiometricTypes();
    for (var type in types) {
      LoggerService.i('Available biometric type: $type');
    }*/
  }

  @override
  void onReady() {
    super.onReady();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    isAuthenticated.value = await _secureStorageService.getIsAuthenticated();
  }

  void onBiometricPressed() {
    Get.toNamed(
      '/login-challenge',
      arguments: {'username': _secureStorageService.readUsername()},
    );
  }

  void onRegisterPressed() {
    Get.toNamed('/phone');
  }

  void onPasscodePressed() {
    Get.toNamed('/registration');
  }
}

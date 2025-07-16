import 'package:get/get.dart';

import '../../../features/registration/presentation/utils/secure_storage_mig.dart';

class SessionManager {
  // Singleton instance
  static final SessionManager _instance = SessionManager._internal();

  // Private constructor
  SessionManager._internal();

  // Factory constructor to return the same instance
  factory SessionManager() => _instance;

  // A flag to indicate whether the user is logged in
  RxBool isLoggedIn = false.obs;

  // Access token
  String? accessToken;

  // SecureStorageService to handle storage
  final SecureStorageServiceMig _secureStorageService = Get.find();

  // Initialize the session (check if a token exists and if it's valid)
  Future<void> initialize() async {
    accessToken = await _secureStorageService.readAccessToken();
    if (accessToken != null) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }

  // Save access token to secure storage and mark as logged in
  Future<void> saveAccessToken(String token) async {
    accessToken = token;
    await _secureStorageService.saveAccessToken(token);
    isLoggedIn.value = true;
  }

  // Log out the user by clearing the access token and marking logged out
  Future<void> logout() async {
    accessToken = null;
    await _secureStorageService.removeAccessToken();
    await _secureStorageService.removeRefreshToken();
    isLoggedIn.value = false;
  }

  // Check if the user is logged in
  bool get isAuthenticated => isLoggedIn.value;
}

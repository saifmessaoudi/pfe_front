class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = '/api';
  static const String iamBaseUrl = '/iam';

  // Endpoints
  static const String registrationChallenge = '$iamBaseUrl/users/registration/challenge';
  static const String completeRegistration = '$iamBaseUrl/users';

  // Login Endpoints (Refactored)
  static const String loginChallenge = '$iamBaseUrl/users/login/challenge';
  static const String completeLogin = '$iamBaseUrl/users/login';

  //Get profile
  static const String getProfile = '$iamBaseUrl/users/get-credentials';

  // Send SMS
  static const String sendSms = '$iamBaseUrl/users/init-otp';
  static const String verifyOtp = '$iamBaseUrl/users/verify-otp';
  // Headers
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  // Timeout durations in seconds
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;
}

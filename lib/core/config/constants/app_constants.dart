class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Passwordless Auth';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'app_theme';

  // Validation
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Sizes
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
}

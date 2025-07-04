import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/home_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/login_challenge_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/otp_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/phone_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/profile_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/root_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/bindings/welcome_binding.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/home_page.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/login_challenge_page.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/otp_page.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/phone_page.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/profile_page.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/root_screen.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/welcome_page.dart';

import '../../../features/registration/presentation/pages/passkey_page.dart';
import 'app_routes.dart';
import '../../../features/registration/presentation/bindings/registration_binding.dart';
import '../../../features/registration/presentation/bindings/passkey_binding.dart';
import '../../../features/registration/presentation/pages/registration_page.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: AppRoutes.WELCOME,
      page: () =>  WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.REGISTRATION,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.PASSKEY,
      page: () => const PasskeyPage(),
      binding: PasskeyBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.OTP,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.PHONE,
      page: () => const PhoneScreen(),
      binding: PhoneBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.LOGIN_CHALLENGE,
      page: () => const LoginChallengeScreen(),
      binding: LoginChallengeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.ROOT,
      page: () => const RootScreen(),
      binding: RootBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}

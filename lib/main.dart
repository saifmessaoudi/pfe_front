import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';

import 'core/config/env/env_config.dart';
import 'core/config/routing/app_pages.dart';
import 'core/config/routing/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/manager/SessionManager.dart';
import 'features/registration/presentation/bindings/welcome_binding.dart';
import 'features/registration/presentation/utils/secure_storage_mig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  await dotenv.load(fileName: "assets/.env");
  await EnvConfig.initialize();
  await GetStorage.init();
  LoggerService.init();
  Get.put(SecureStorageServiceMig());

  await SessionManager().initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = getInitialRoute();

    return GetMaterialApp(
      title: 'Fido Authenticator',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      initialBinding: WelcomeBinding(),
      logWriterCallback: LoggerService.write,
      defaultTransition: Transition.fade,
    );
  }

  String getInitialRoute() {
    if (SessionManager().isAuthenticated) {
      return AppRoutes.WELCOME;
    } else {
      return AppRoutes.WELCOME;
    }
  }
}

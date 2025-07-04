import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_authenticator_fido/features/registration/presentation/pages/profile_page.dart';
import '../../../../core/config/routing/app_routes.dart';
import '../../../../core/utils/manager/SessionManager.dart';
import '../controllers/root_controller.dart';
import 'home_page.dart';
import 'package:mobile_authenticator_fido/core/utils/logger/logger.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  // Track the number of times the app goes to background
  int backgroundCount = 0;
  // Store the timestamp of the first background entry
  DateTime? firstBackgroundTime;

  // List of pages to switch between
  final List<Widget> pages = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Register the observer to listen to app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Always remove the observer when it's not needed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      firstBackgroundTime ??= DateTime.now();

      Duration timeDifference = DateTime.now().difference(firstBackgroundTime!);
      if (timeDifference.inMinutes >= 1) {
        backgroundCount = 0;
        firstBackgroundTime = DateTime.now();
      }

      backgroundCount++;
      LoggerService.d('App went to background $backgroundCount times');
      if (backgroundCount > 3) {
        clearAccessToken();
      }
    }
    if (state == AppLifecycleState.resumed) {
      LoggerService.d('App is resumed from background');
    }
  }

  void clearAccessToken() async {
    await SessionManager().logout();
  }

  @override
  Widget build(BuildContext context) {
    final RootController controller = Get.find<RootController>();
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent.withValues(alpha:0.45),
              elevation: 1,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changeTab,
              selectedItemColor: const Color(0xFFEBAC1D),
              unselectedItemColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

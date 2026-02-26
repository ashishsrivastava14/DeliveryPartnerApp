import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'controllers/auth_controller.dart';
import 'controllers/onboarding_controller.dart';
import 'controllers/partner_home_controller.dart';
import 'controllers/admin_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all GetX controllers
  Get.put(AuthController());
  Get.put(OnboardingController());
  Get.put(PartnerHomeController());
  Get.put(AdminController());

  runApp(const DeliveryPartnerApp());
}

class DeliveryPartnerApp extends StatelessWidget {
  const DeliveryPartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Delivery Partner App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}

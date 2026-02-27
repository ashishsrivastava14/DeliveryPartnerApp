import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/auth/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/role_selector_screen.dart';
import '../../screens/partner/partner_shell.dart';
import '../../screens/partner/partner_home_screen.dart';
import '../../screens/partner/order_history_screen.dart';
import '../../screens/partner/earnings_screen.dart';
import '../../screens/partner/profile_screen.dart';
import '../../screens/partner/active_order_screen.dart';
import '../../screens/partner/onboarding_screen.dart';
import '../../screens/partner/notifications_screen.dart';
import '../../screens/partner/support_screen.dart';
import '../../screens/admin/admin_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _partnerShellKey = GlobalKey<NavigatorState>(debugLabel: 'partnerShell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // ── Auth ──
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/role-selector',
      builder: (context, state) => RoleSelectorScreen(),
    ),

    // ── Partner Onboarding ──
    GoRoute(
      path: '/partner/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),

    // ── Partner Shell with Bottom Nav ──
    ShellRoute(
      navigatorKey: _partnerShellKey,
      builder: (context, state, child) => PartnerShell(child: child),
      routes: [
        GoRoute(
          path: '/partner/home',
          pageBuilder: (context, state) => NoTransitionPage(
            child: PartnerHomeScreen(),
          ),
        ),
        GoRoute(
          path: '/partner/orders',
          pageBuilder: (context, state) => NoTransitionPage(
            child: OrderHistoryScreen(),
          ),
        ),
        GoRoute(
          path: '/partner/earnings',
          pageBuilder: (context, state) => NoTransitionPage(
            child: EarningsScreen(),
          ),
        ),
        GoRoute(
          path: '/partner/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),

    // ── Partner Detail Screens (outside shell) ──
    GoRoute(
      path: '/partner/active-order',
      builder: (context, state) => ActiveOrderScreen(),
    ),
    GoRoute(
      path: '/partner/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/partner/support',
      builder: (context, state) => const SupportScreen(),
    ),

    // ── Admin Panel (self-contained shell) ──
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => AdminShell(),
    ),
  ],
);

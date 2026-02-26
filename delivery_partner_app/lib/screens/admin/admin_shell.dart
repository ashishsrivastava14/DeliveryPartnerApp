import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/admin_controller.dart';
import '../../core/widgets/common_widgets.dart';
import 'admin_dashboard_screen.dart';
import 'admin_partners_screen.dart';
import 'admin_orders_screen.dart';
import 'admin_payouts_screen.dart';
import 'admin_zones_screen.dart';
import 'admin_broadcasts_screen.dart';
import 'admin_reports_screen.dart';
import 'admin_settings_screen.dart';

class AdminShell extends StatelessWidget {
  AdminShell({super.key});

  final AdminController controller = Get.find<AdminController>();

  final _screens = <Widget>[
    AdminDashboardScreen(),
    AdminPartnersScreen(),
    AdminOrdersScreen(),
    AdminPayoutsScreen(),
    AdminZonesScreen(),
    AdminBroadcastsScreen(),
    AdminReportsScreen(),
    AdminSettingsScreen(),
  ];

  final _navItems = const [
    NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
    NavigationRailDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: Text('Partners')),
    NavigationRailDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: Text('Orders')),
    NavigationRailDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments), label: Text('Payouts')),
    NavigationRailDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: Text('Zones')),
    NavigationRailDestination(icon: Icon(Icons.campaign_outlined), selectedIcon: Icon(Icons.campaign), label: Text('Broadcasts')),
    NavigationRailDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: Text('Reports')),
    NavigationRailDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Theme(
      data: AppTheme.darkAdminTheme,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: Obx(() => Row(
              children: [
                if (isWide)
                  NavigationRail(
                    selectedIndex: controller.selectedNavIndex.value,
                    onDestinationSelected: (i) => controller.selectedNavIndex.value = i,
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: AppColors.surfaceDark,
                    destinations: _navItems,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.admin_panel_settings,
                                color: Colors.white, size: 24),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                if (isWide)
                  const VerticalDivider(width: 1, color: AppColors.cardDark),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _screens[controller.selectedNavIndex.value],
                  ),
                ),
              ],
            )),
        bottomNavigationBar: isWide
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const PoweredByQuickPrepAI(light: true),
                  Obx(() => BottomNavigationBar(
                  currentIndex: controller.selectedNavIndex.value.clamp(0, 4),
                  onTap: (i) => controller.selectedNavIndex.value = i,
                  backgroundColor: AppColors.surfaceDark,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.white38,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Partners'),
                    BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
                    BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payouts'),
                    BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
                  ],
                )),
                ],
              ),
      ),
    );
  }
}

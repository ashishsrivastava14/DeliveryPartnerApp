import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/partner_home_controller.dart';

class PartnerShell extends StatelessWidget {
  final Widget child;

  PartnerShell({super.key, required this.child});

  final PartnerHomeController controller = Get.find<PartnerHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.bottomNavIndex.value,
            onTap: (index) {
              controller.bottomNavIndex.value = index;
              switch (index) {
                case 0:
                  context.go('/partner/home');
                  break;
                case 1:
                  context.go('/partner/orders');
                  break;
                case 2:
                  context.go('/partner/earnings');
                  break;
                case 3:
                  context.go('/partner/profile');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                activeIcon: Icon(Icons.account_balance_wallet),
                label: 'Earnings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}

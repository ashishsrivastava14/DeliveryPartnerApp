import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/partner_home_controller.dart';
import 'new_order_alert.dart';

class PartnerHomeScreen extends StatelessWidget {
  PartnerHomeScreen({super.key});

  final PartnerHomeController controller = Get.find<PartnerHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App bar with earnings banner
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello, Amit! 👋',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Ready to deliver?',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => context.push('/partner/notifications'),
                                      icon: const Icon(Icons.notifications_outlined,
                                          color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: () => context.push('/partner/support'),
                                      icon: const Icon(Icons.help_outline, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Persistent earnings banner
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.account_balance_wallet,
                                              color: AppColors.accent, size: 20),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Today's Earnings",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 13,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹${controller.todayEarnings.value.toStringAsFixed(0)}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.accent,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text('Dashboard', style: GoogleFonts.poppins(fontSize: 18)),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Online/Offline Toggle
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                        controller.isOnline.value
                                            ? 'You are Online'
                                            : 'You are Offline',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  Obx(() => Text(
                                        controller.isOnline.value
                                            ? 'Accepting new orders'
                                            : 'Go online to receive orders',
                                        style: GoogleFonts.dmSans(
                                          fontSize: 13,
                                          color: AppColors.textSecondary,
                                        ),
                                      )),
                                ],
                              ),
                              Obx(() => AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Switch(
                                      key: ValueKey(controller.isOnline.value),
                                      value: controller.isOnline.value,
                                      onChanged: (_) => controller.toggleOnline(),
                                      activeThumbColor: AppColors.primary,
                                      activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Today's Stats
                      Text(
                        "Today's Performance",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.receipt_long,
                              value: Obx(() => Text(
                                    '${controller.ordersDelivered.value}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  )),
                              label: 'Delivered',
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.route,
                              value: Obx(() => Text(
                                    '${controller.distanceCovered.value} km',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.info,
                                    ),
                                  )),
                              label: 'Distance',
                              color: AppColors.info,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Active Order Card
                      Obx(() {
                        if (!controller.hasActiveOrder.value) {
                          return _EmptyActiveOrder();
                        }
                        return _ActiveOrderCard(controller: controller);
                      }),

                      const SizedBox(height: 16),

                      // Quick Actions
                      Text(
                        'Quick Actions',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _QuickAction(
                            icon: Icons.history,
                            label: 'History',
                            onTap: () => context.go('/partner/orders'),
                          ),
                          const SizedBox(width: 12),
                          _QuickAction(
                            icon: Icons.wallet,
                            label: 'Earnings',
                            onTap: () => context.go('/partner/earnings'),
                          ),
                          const SizedBox(width: 12),
                          _QuickAction(
                            icon: Icons.support_agent,
                            label: 'Support',
                            onTap: () => context.push('/partner/support'),
                          ),
                          const SizedBox(width: 12),
                          _QuickAction(
                            icon: Icons.person,
                            label: 'Profile',
                            onTap: () => context.go('/partner/profile'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Incentive Preview
                      Text(
                        'Active Incentives',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...controller.incentives.where((i) => i.isActive).take(2).map(
                            (incentive) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.emoji_events,
                                            color: AppColors.accent, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            incentive.title,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '₹${incentive.bonusAmount.toStringAsFixed(0)}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      incentive.description,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: incentive.progress,
                                        backgroundColor: AppColors.divider,
                                        color: AppColors.primary,
                                        minHeight: 6,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${incentive.completedOrders}/${incentive.targetOrders} orders completed',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // New Order Alert Overlay
          Obx(() {
            if (controller.showNewOrderAlert.value) {
              return NewOrderAlertOverlay(controller: controller);
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Widget value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            value,
            Text(
              label,
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  final PartnerHomeController controller;

  const _ActiveOrderCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final order = controller.activeOrder;
    return Hero(
      tag: 'order-${order.id}',
      child: Card(
        color: AppColors.primary.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: InkWell(
          onTap: () => context.push('/partner/active-order'),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('ACTIVE',
                          style: GoogleFonts.dmSans(
                              fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    const Spacer(),
                    Text(order.id,
                        style: GoogleFonts.dmSans(
                            fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.store, size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(order.storeName,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(order.customerAddress,
                          style: GoogleFonts.dmSans(
                              fontSize: 13, color: AppColors.textSecondary)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _OrderInfoChip(Icons.shopping_bag, '${order.itemsCount} items'),
                        _OrderInfoChip(Icons.route, '${order.distance} km'),
                        _OrderInfoChip(Icons.currency_rupee, '₹${order.payout}'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            controller.currentStepLabel,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OrderInfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _EmptyActiveOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/logo.png', width: 48, height: 48),
            ),
            const SizedBox(height: 12),
            Text(
              'No Active Orders',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'Go online to start receiving orders',
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

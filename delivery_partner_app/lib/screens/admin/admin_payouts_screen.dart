import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/admin_controller.dart';
import '../../mock/mock_earnings.dart';

class AdminPayoutsScreen extends StatelessWidget {
  AdminPayoutsScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Earnings & Payouts', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payout Requests
            Text('Pending Payouts',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Obx(() => Column(
                  children: controller.payoutRequests.map((payout) {
                    return Card(
                      color: AppColors.cardDark,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(payout.partnerName,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                                    Text(payout.partnerId,
                                        style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
                                  ],
                                ),
                                Text('₹${payout.amount.toStringAsFixed(0)}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.accent)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Requested: ${_timeAgo(payout.requestDate)}',
                                    style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white38)),
                                _PayoutStatus(payout.status),
                              ],
                            ),
                            if (payout.status == 'pending') ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => _showConfirmDialog(
                                        context, 'Reject Payout',
                                        'Reject payout of ₹${payout.amount.toStringAsFixed(0)} for ${payout.partnerName}?',
                                        () => controller.rejectPayout(payout.id),
                                        AppColors.error,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColors.error,
                                        side: const BorderSide(color: AppColors.error),
                                      ),
                                      child: const Text('Reject'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _showConfirmDialog(
                                        context, 'Approve Payout',
                                        'Approve payout of ₹${payout.amount.toStringAsFixed(0)} for ${payout.partnerName}?',
                                        () => controller.approvePayout(payout.id),
                                        AppColors.success,
                                      ),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                                      child: const Text('Approve'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 24),

            // Incentive Plans Management
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Incentive Plans',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                IconButton(
                  onPressed: () => _showAddIncentiveDialog(context),
                  icon: const Icon(Icons.add_circle, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() => Column(
                  children: controller.incentivePlans.map((plan) {
                    return Card(
                      color: AppColors.cardDark,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.emoji_events, color: AppColors.accent),
                        ),
                        title: Text(plan.title,
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${plan.description} — ₹${plan.bonusAmount.toStringAsFixed(0)} bonus',
                                style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
                            const SizedBox(height: 4),
                            Text(plan.isActive ? '🟢 Active' : '🔴 Inactive',
                                style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white38)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                          onPressed: () => controller.deleteIncentive(plan.id),
                        ),
                      ),
                    );
                  }).toList(),
                )),
          ],
        ),
      ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, String title, String message,
      VoidCallback onConfirm, Color color) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text(title, style: GoogleFonts.poppins(color: Colors.white)),
        content: Text(message, style: GoogleFonts.dmSans(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.dmSans(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: color),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showAddIncentiveDialog(BuildContext context) {
    final titleC = TextEditingController();
    final descC = TextEditingController();
    final targetC = TextEditingController();
    final bonusC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Add Incentive Plan', style: GoogleFonts.poppins(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleC, style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(hintText: 'Plan title')),
              const SizedBox(height: 8),
              TextField(controller: descC, style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(hintText: 'Description')),
              const SizedBox(height: 8),
              TextField(controller: targetC, keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(hintText: 'Target orders')),
              const SizedBox(height: 8),
              TextField(controller: bonusC, keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(hintText: 'Bonus amount (₹)')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.dmSans(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addIncentive(IncentivePlan(
                id: 'INC-${DateTime.now().millisecondsSinceEpoch}',
                title: titleC.text.isEmpty ? 'New Plan' : titleC.text,
                description: descC.text.isEmpty ? 'Complete orders' : descC.text,
                targetOrders: int.tryParse(targetC.text) ?? 10,
                completedOrders: 0,
                bonusAmount: double.tryParse(bonusC.text) ?? 100,
                isActive: true,
              ));
              Navigator.pop(ctx);
            },
            child: const Text('Add Plan'),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class _PayoutStatus extends StatelessWidget {
  final String status;
  const _PayoutStatus(this.status);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'approved': color = AppColors.success; break;
      case 'rejected': color = AppColors.error; break;
      case 'pending': color = AppColors.accent; break;
      default: color = AppColors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(status.toUpperCase(),
          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

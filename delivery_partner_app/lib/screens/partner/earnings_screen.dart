import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/partner_home_controller.dart';
import '../../mock/mock_earnings.dart';

class EarningsScreen extends StatelessWidget {
  EarningsScreen({super.key});

  final PartnerHomeController controller = Get.find<PartnerHomeController>();
  final RxInt selectedTab = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Total Earnings',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: MockEarnings.todayEarnings),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Text(
                              '₹${value.toStringAsFixed(0)}',
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Today's earnings",
                          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white54),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _EarningStat('This Week', '₹${MockEarnings.weekEarnings.toStringAsFixed(0)}'),
                            Container(width: 1, height: 30, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 24)),
                            _EarningStat('This Month', '₹${MockEarnings.monthEarnings.toStringAsFixed(0)}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: Text('Earnings', style: GoogleFonts.poppins(fontSize: 18)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tab selector
                  Obx(() => Row(
                        children: [
                          _TabChip('Breakdown', 0, selectedTab),
                          const SizedBox(width: 8),
                          _TabChip('Incentives', 1, selectedTab),
                          const SizedBox(width: 8),
                          _TabChip('Transactions', 2, selectedTab),
                        ],
                      )),
                  const SizedBox(height: 16),

                  Obx(() {
                    switch (selectedTab.value) {
                      case 0:
                        return _BreakdownView();
                      case 1:
                        return _IncentivesView(controller: controller);
                      case 2:
                        return _TransactionsView(controller: controller);
                      default:
                        return const SizedBox();
                    }
                  }),

                  const SizedBox(height: 20),

                  // Withdrawal Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Available Balance',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 13, color: AppColors.textSecondary)),
                                  Text(
                                    '₹${MockEarnings.availableBalance.toStringAsFixed(0)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _showWithdrawFlow(context),
                                icon: const Icon(Icons.account_balance, size: 18),
                                label: const Text('Withdraw'),
                              ),
                            ],
                          ),
                        ],
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
    );
  }

  void _showWithdrawFlow(BuildContext context) {
    final amountController = TextEditingController();
    final step = 0.obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24, right: 24, top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Obx(() {
          if (step.value == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Withdraw Funds',
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter amount',
                    prefixText: '₹ ',
                  ),
                ),
                const SizedBox(height: 8),
                Text('Available: ₹${MockEarnings.availableBalance.toStringAsFixed(0)}',
                    style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => step.value = 1,
                    child: const Text('Confirm Withdrawal'),
                  ),
                ),
              ],
            );
          } else if (step.value == 1) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, size: 64, color: AppColors.success),
                const SizedBox(height: 16),
                Text('Withdrawal Successful!',
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('₹${amountController.text.isEmpty ? "0" : amountController.text} will be transferred to your bank account',
                    style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary),
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Done'),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

class _EarningStat extends StatelessWidget {
  final String label;
  final String value;

  const _EarningStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label,
            style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white60)),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final int index;
  final RxInt selectedTab;

  const _TabChip(this.label, this.index, this.selectedTab);

  @override
  Widget build(BuildContext context) {
    final selected = selectedTab.value == index;
    return GestureDetector(
      onTap: () => selectedTab.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _BreakdownView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: MockEarnings.earningBreakdown.map((entry) {
        final isNegative = entry.amount < 0;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _typeColor(entry.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_typeIcon(entry.type), color: _typeColor(entry.type), size: 20),
            ),
            title: Text(entry.label,
                style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
            trailing: Text(
              '${isNegative ? "-" : "+"}₹${entry.amount.abs().toStringAsFixed(0)}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isNegative ? AppColors.error : AppColors.success,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'base': return AppColors.primary;
      case 'incentive': return AppColors.accent;
      case 'tip': return AppColors.info;
      case 'penalty': return AppColors.error;
      default: return AppColors.textSecondary;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'base': return Icons.currency_rupee;
      case 'incentive': return Icons.emoji_events;
      case 'tip': return Icons.favorite;
      case 'penalty': return Icons.warning;
      default: return Icons.money;
    }
  }
}

class _IncentivesView extends StatelessWidget {
  final PartnerHomeController controller;

  const _IncentivesView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.incentives.map((incentive) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (incentive.isActive ? AppColors.accent : AppColors.success)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        incentive.isActive ? Icons.emoji_events : Icons.check_circle,
                        color: incentive.isActive ? AppColors.accent : AppColors.success,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(incentive.title,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                          Text(incentive.description,
                              style: GoogleFonts.dmSans(
                                  fontSize: 13, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Text(
                      '₹${incentive.bonusAmount.toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: incentive.progress,
                    backgroundColor: AppColors.divider,
                    color: incentive.progress >= 1.0 ? AppColors.success : AppColors.primary,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${incentive.completedOrders}/${incentive.targetOrders} orders',
                      style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    Text(
                      incentive.progress >= 1.0
                          ? 'Completed! ✅'
                          : '${(incentive.progress * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: incentive.progress >= 1.0
                            ? AppColors.success
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TransactionsView extends StatelessWidget {
  final PartnerHomeController controller;

  const _TransactionsView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.transactions.map((tx) {
        final isNegative = tx.amount < 0;
        return Card(
          margin: const EdgeInsets.only(bottom: 6),
          child: ListTile(
            dense: true,
            leading: Icon(
              isNegative ? Icons.arrow_downward : Icons.arrow_upward,
              color: isNegative ? AppColors.error : AppColors.success,
              size: 20,
            ),
            title: Text(tx.label,
                style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
            subtitle: Text(
              _timeAgo(tx.date),
              style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary),
            ),
            trailing: Text(
              '${isNegative ? "" : "+"}₹${tx.amount.abs().toStringAsFixed(0)}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isNegative ? AppColors.error : AppColors.success,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

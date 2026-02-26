import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/admin_controller.dart';
import '../../mock/mock_orders.dart';

class AdminOrdersScreen extends StatelessWidget {
  AdminOrdersScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Order Management', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: AppBackground(
        child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: controller.allOrders.length,
        itemBuilder: (context, index) {
          final order = controller.allOrders[index];
          return Card(
            color: AppColors.cardDark,
            margin: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: () => _showOrderDetail(context, order),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.id,
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        _StatusChip(order.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.store, size: 16, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(order.storeName,
                              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white70)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: AppColors.accent),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(order.customerName,
                              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white70)),
                        ),
                        Text('₹${order.payout.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.success)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text('${order.itemsCount} items • ${order.distance} km',
                            style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white38)),
                        const Spacer(),
                        Text(_timeAgo(order.createdAt),
                            style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white38)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }

  void _showOrderDetail(BuildContext context, MockOrder order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id,
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                _StatusChip(order.status),
              ],
            ),
            const SizedBox(height: 16),
            // Timeline
            _TimelineItem('Order Created', _timeAgo(order.createdAt), true),
            _TimelineItem('Assigned to Partner', 'Amit Sharma', order.status != 'pending'),
            _TimelineItem('Picked Up', 'From ${order.storeName}', order.status == 'delivered'),
            _TimelineItem('Delivered', 'To ${order.customerName}', order.status == 'delivered'),
            const SizedBox(height: 16),
            // Assign to partner
            if (order.status == 'active' || order.status == 'pending')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Assign to Partner',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppColors.cardDark,
                    style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: AppColors.cardDark,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: controller.allPartners
                        .where((p) => p.status == 'active')
                        .map((p) => DropdownMenuItem(value: p.id, child: Text(p.name)))
                        .toList(),
                    onChanged: (val) {},
                    hint: Text('Select partner', style: GoogleFonts.dmSans(color: Colors.white38)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order assigned successfully'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      child: const Text('Assign Order'),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
          ],
        ),
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

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'delivered': color = AppColors.success; break;
      case 'active': color = AppColors.accent; break;
      case 'pending': color = AppColors.info; break;
      case 'cancelled': color = AppColors.error; break;
      default: color = AppColors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status.toUpperCase(),
          style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;

  const _TimelineItem(this.title, this.subtitle, this.isCompleted);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.primary : AppColors.cardDark,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? AppColors.primary : Colors.white24,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600,
                        color: isCompleted ? Colors.white : Colors.white38)),
                Text(subtitle,
                    style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

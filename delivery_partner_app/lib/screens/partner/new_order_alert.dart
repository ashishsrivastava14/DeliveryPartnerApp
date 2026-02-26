import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/partner_home_controller.dart';

class NewOrderAlertOverlay extends StatelessWidget {
  final PartnerHomeController controller;

  const NewOrderAlertOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final order = controller.newOrder;
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Countdown timer ring
              Obx(() => SizedBox(
                    width: 80,
                    height: 80,
                    child: CustomPaint(
                      painter: _CountdownPainter(
                        progress: controller.orderCountdown.value / 30,
                        color: controller.orderCountdown.value > 10
                            ? AppColors.primary
                            : AppColors.error,
                      ),
                      child: Center(
                        child: Text(
                          '${controller.orderCountdown.value}',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: controller.orderCountdown.value > 10
                                ? AppColors.primary
                                : AppColors.error,
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                'New Order! 🎉',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              // Store info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.store, color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            order.storeName,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: AppColors.error, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            order.customerAddress,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Order details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _OrderMetric(
                    icon: Icons.shopping_bag,
                    value: '${order.itemsCount}',
                    label: 'Items',
                  ),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _OrderMetric(
                    icon: Icons.route,
                    value: '${order.distance} km',
                    label: 'Distance',
                  ),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _OrderMetric(
                    icon: Icons.currency_rupee,
                    value: '₹${order.payout.toStringAsFixed(0)}',
                    label: 'Payout',
                    highlight: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.rejectOrder,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: controller.acceptOrder,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Accept Order'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool highlight;

  const _OrderMetric({
    required this.icon,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: highlight ? AppColors.accent : AppColors.textSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: highlight ? AppColors.accent : AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _CountdownPainter extends CustomPainter {
  final double progress;
  final Color color;

  _CountdownPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CountdownPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

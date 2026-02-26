import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/partner_home_controller.dart';

class ActiveOrderScreen extends StatelessWidget {
  ActiveOrderScreen({super.key});

  final PartnerHomeController controller = Get.find<PartnerHomeController>();

  @override
  Widget build(BuildContext context) {
    final order = controller.activeOrder;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Order ${order.id}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Obx(() {
        if (controller.isOrderCompleted.value) {
          return _OrderCompletedView(controller: controller);
        }
        return Column(
          children: [
            // Step Tracker
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Obx(() => Row(
                    children: List.generate(5, (index) {
                      final labels = ['Assigned', 'Reached', 'Picked Up', 'En Route', 'Delivered'];
                      final icons = [
                        Icons.assignment,
                        Icons.store,
                        Icons.inventory_2,
                        Icons.local_shipping,
                        Icons.check_circle,
                      ];
                      final isCompleted = index <= controller.currentOrderStep.value;
                      final isCurrent = index == controller.currentOrderStep.value;
                      return Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isCompleted ? AppColors.primary : AppColors.divider,
                                shape: BoxShape.circle,
                                border: isCurrent
                                    ? Border.all(color: AppColors.accent, width: 3)
                                    : null,
                              ),
                              child: Icon(
                                icons[index],
                                size: 18,
                                color: isCompleted ? Colors.white : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              labels[index],
                              style: GoogleFonts.dmSans(
                                fontSize: 9,
                                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                color: isCompleted ? AppColors.primary : AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }),
                  )),
            ),
            const Divider(height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mock Map
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.info.withValues(alpha: 0.1),
                          ],
                        ),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Stack(
                        children: [
                          // Grid lines
                          ...List.generate(8, (i) => Positioned(
                            left: 0,
                            right: 0,
                            top: i * 25.0 + 10,
                            child: Container(height: 0.5, color: AppColors.divider),
                          )),
                          ...List.generate(12, (i) => Positioned(
                            top: 0,
                            bottom: 0,
                            left: i * 30.0 + 10,
                            child: Container(width: 0.5, color: AppColors.divider),
                          )),
                          // Route line
                          CustomPaint(
                            size: const Size(double.infinity, 200),
                            painter: _RoutePainter(),
                          ),
                          // Store marker
                          Positioned(
                            left: 40,
                            top: 60,
                            child: _MapMarker(
                              icon: Icons.store,
                              color: AppColors.primary,
                              label: 'Store',
                            ),
                          ),
                          // Customer marker
                          Positioned(
                            right: 40,
                            bottom: 40,
                            child: _MapMarker(
                              icon: Icons.person_pin,
                              color: AppColors.error,
                              label: 'Customer',
                            ),
                          ),
                          // Center label
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Text(
                                '${order.distance} km • ~15 min',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Contact buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call, size: 18),
                            label: const Text('Call Store'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call, size: 18),
                            label: const Text('Call Customer'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.accent,
                              side: const BorderSide(color: AppColors.accent),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Order details
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Details',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            _DetailRow(Icons.store, 'Store', order.storeName),
                            _DetailRow(Icons.location_on, 'Store Address', order.storeAddress),
                            _DetailRow(Icons.person, 'Customer', order.customerName),
                            _DetailRow(Icons.home, 'Delivery Address', order.customerAddress),
                            _DetailRow(Icons.shopping_bag, 'Items', '${order.itemsCount} items'),
                            _DetailRow(Icons.currency_rupee, 'Payout',
                                '₹${order.payout.toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom action
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Obx(() {
                if (controller.currentOrderStep.value == 3) {
                  // En Route → show slide to deliver with OTP
                  return _SlideToConfirmButton(
                    label: 'Slide to Deliver',
                    onConfirm: () => _showOtpVerification(context),
                  );
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.advanceOrderStep,
                    child: Text(_nextStepLabel(controller.currentOrderStep.value)),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  String _nextStepLabel(int step) {
    switch (step) {
      case 0:
        return 'Reached Store';
      case 1:
        return 'Picked Up Order';
      case 2:
        return 'Start Delivery';
      default:
        return 'Next';
    }
  }

  void _showOtpVerification(BuildContext context) {
    final otpController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(Icons.lock, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'Enter Delivery OTP',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Ask the customer for 4-digit OTP',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 12),
              decoration: InputDecoration(
                hintText: '● ● ● ●',
                counterText: '',
                hintStyle: GoogleFonts.poppins(fontSize: 28, color: AppColors.divider),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hint: OTP is 1234',
              style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.accent),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.verifyDeliveryOtp(otpController.text)) {
                    Navigator.pop(ctx);
                    controller.advanceOrderStep();
                  }
                },
                child: const Text('Verify & Complete Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideToConfirmButton extends StatefulWidget {
  final String label;
  final VoidCallback onConfirm;

  const _SlideToConfirmButton({required this.label, required this.onConfirm});

  @override
  State<_SlideToConfirmButton> createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<_SlideToConfirmButton> {
  double _dragPosition = 0;
  final double _maxDrag = 260;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          // Label
          Center(
            child: Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
          // Draggable slider
          Positioned(
            left: _dragPosition,
            top: 4,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition = (_dragPosition + details.delta.dx).clamp(0, _maxDrag);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= _maxDrag * 0.85) {
                  widget.onConfirm();
                }
                setState(() => _dragPosition = 0);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCompletedView extends StatelessWidget {
  final PartnerHomeController controller;

  const _OrderCompletedView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebration
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.celebration, size: 64, color: AppColors.success),
            ),
            const SizedBox(height: 24),
            Text(
              'Order Delivered! 🎉',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Great job on completing this delivery!',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            // Earnings summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Earnings Summary',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    _EarningSummaryRow('Base Pay', '₹35'),
                    _EarningSummaryRow('Distance Bonus', '₹12'),
                    _EarningSummaryRow('Peak Hour Bonus', '₹8'),
                    const Divider(),
                    _EarningSummaryRow('Total', '₹55', isBold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.completeOrderFlow();
                  context.go('/partner/home');
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _EarningSummaryRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                color: isBold ? AppColors.primary : AppColors.textPrimary,
              )),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(label,
                style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _MapMarker({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 8)],
          ),
          child: Icon(icon, size: 16, color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(label, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(60, 85);
    path.cubicTo(
      size.width * 0.3, size.height * 0.2,
      size.width * 0.6, size.height * 0.8,
      size.width - 60, size.height - 55,
    );

    // Dashed line
    final dashPath = Path();
    const dashWidth = 8.0;
    const dashSpace = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        dashPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

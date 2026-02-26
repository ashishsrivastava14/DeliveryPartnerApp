import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/admin_controller.dart';

class AdminBroadcastsScreen extends StatelessWidget {
  AdminBroadcastsScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Notifications & Broadcasts', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compose Broadcast
            Card(
              color: AppColors.cardDark,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Compose Broadcast',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 16),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(hintText: 'Notification title'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: const InputDecoration(hintText: 'Message body'),
                    ),
                    const SizedBox(height: 12),
                    Text('Target Audience',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.cardDark,
                      style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: AppColors.cardDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: ['All Partners', 'By Zone', 'Individual']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (_) {},
                      hint: Text('Select target', style: GoogleFonts.dmSans(color: Colors.white38)),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.sendBroadcast({
                            'title': 'New Broadcast',
                            'target': 'All Partners',
                            'date': '2025-02-26',
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Broadcast sent successfully!'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Send Broadcast'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sent History
            Text('Sent Broadcasts',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Obx(() => Column(
                  children: controller.broadcastHistory.map((broadcast) {
                    return Card(
                      color: AppColors.cardDark,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.campaign, color: AppColors.primary, size: 20),
                        ),
                        title: Text(broadcast['title'] ?? '',
                            style: GoogleFonts.dmSans(
                                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                        subtitle: Text(
                          'To: ${broadcast['target']} • ${broadcast['date']}',
                          style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54),
                        ),
                        trailing: const Icon(Icons.check_circle, color: AppColors.success, size: 20),
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
}

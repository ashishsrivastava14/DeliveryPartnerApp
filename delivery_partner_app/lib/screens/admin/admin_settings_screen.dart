import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../controllers/admin_controller.dart';

class AdminSettingsScreen extends StatelessWidget {
  AdminSettingsScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Settings', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Profile
            Card(
              color: AppColors.cardDark,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary,
                      child: Text('AD',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Admin User',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                          const SizedBox(height: 2),
                          Text('admin@zeptpartner.com',
                              style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white54)),
                          const SizedBox(height: 2),
                          Text('Super Admin',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white38),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Edit profile coming soon')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Feature Toggles
            Text('Feature Toggles',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              child: Obx(() => Column(
                    children: [
                      _buildToggleTile(
                        icon: Icons.lock_outline,
                        title: 'OTP Verification',
                        subtitle: 'Require OTP on delivery confirmation',
                        value: controller.otpVerificationEnabled.value,
                        onChanged: (_) => controller.otpVerificationEnabled.toggle(),
                      ),
                      const Divider(color: Colors.white12, height: 1),
                      _buildToggleTile(
                        icon: Icons.auto_awesome,
                        title: 'Auto-Assign Orders',
                        subtitle: 'Automatically assign orders to nearest partner',
                        value: controller.autoAssignEnabled.value,
                        onChanged: (_) => controller.autoAssignEnabled.toggle(),
                      ),
                      const Divider(color: Colors.white12, height: 1),
                      _buildToggleTile(
                        icon: Icons.trending_up,
                        title: 'Surge Pricing',
                        subtitle: 'Enable dynamic pricing during peak hours',
                        value: controller.surgePricingEnabled.value,
                        onChanged: (_) => controller.surgePricingEnabled.toggle(),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 24),

            // App Configuration
            Text('App Configuration',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              child: Column(
                children: [
                  _buildConfigTile(
                    icon: Icons.timer,
                    title: 'Order Accept Timeout',
                    value: '30 seconds',
                    onTap: () => _showEditDialog(context, 'Order Accept Timeout', '30'),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _buildConfigTile(
                    icon: Icons.location_on,
                    title: 'Max Delivery Radius',
                    value: '5 km',
                    onTap: () => _showEditDialog(context, 'Max Delivery Radius', '5'),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _buildConfigTile(
                    icon: Icons.star,
                    title: 'Min Partner Rating',
                    value: '3.5',
                    onTap: () => _showEditDialog(context, 'Min Partner Rating', '3.5'),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _buildConfigTile(
                    icon: Icons.percent,
                    title: 'Platform Commission',
                    value: '5%',
                    onTap: () => _showEditDialog(context, 'Platform Commission', '5'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // System Info
            Text('System Info',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              child: Column(
                children: [
                  _buildInfoTile(icon: Icons.info_outline, title: 'App Version', value: '1.0.0'),
                  const Divider(color: Colors.white12, height: 1),
                  _buildInfoTile(icon: Icons.build, title: 'Build Number', value: '2025.02.26'),
                  const Divider(color: Colors.white12, height: 1),
                  _buildInfoTile(icon: Icons.dns, title: 'Environment', value: 'Production'),
                  const Divider(color: Colors.white12, height: 1),
                  _buildInfoTile(icon: Icons.storage, title: 'API Version', value: 'v2.1'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Danger Zone
            Text('Danger Zone',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.error)),
            const SizedBox(height: 12),
            Card(
              color: AppColors.cardDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: AppColors.error),
                    title: Text('Clear All Data',
                        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.error)),
                    subtitle: Text('Reset mock data to defaults',
                        style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white38)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white24),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: AppColors.cardDark,
                          title: Text('Clear All Data?',
                              style: GoogleFonts.poppins(color: Colors.white)),
                          content: Text(
                            'This will reset all mock data. Are you sure?',
                            style: GoogleFonts.dmSans(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('All data cleared!'),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error),
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: AppColors.error),
                    title: Text('Logout',
                        style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.error)),
                    subtitle: Text('Sign out of admin panel',
                        style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white38)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white24),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out (mock)')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: (value ? AppColors.primary : Colors.white12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: value ? Colors.white : Colors.white38, size: 20),
      ),
      title: Text(title,
          style: GoogleFonts.dmSans(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      subtitle: Text(subtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white54)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildConfigTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title,
          style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.primary)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white38, size: 20),
      title: Text(title,
          style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white70)),
      trailing: Text(value,
          style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  void _showEditDialog(BuildContext context, String title, String currentValue) {
    final textController = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text('Edit $title', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
        content: TextField(
          controller: textController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter new value',
            hintStyle: const TextStyle(color: Colors.white38),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title updated to ${textController.text}'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/onboarding_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final OnboardingController onboardingController = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('My Profile'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => onboardingController.toggleEditMode(),
            child: Obx(() => Text(
                  onboardingController.isEditMode.value ? 'Save' : 'Edit',
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ],
      ),
      body: AppBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Amit Sharma',
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '+91 98765 43210',
                      style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ProfileStat('1,250', 'Orders'),
                        Container(
                            width: 1, height: 30, color: AppColors.divider,
                            margin: const EdgeInsets.symmetric(horizontal: 20)),
                        _ProfileStat('4.8 ⭐', 'Rating'),
                        Container(
                            width: 1, height: 30, color: AppColors.divider,
                            margin: const EdgeInsets.symmetric(horizontal: 20)),
                        _ProfileStat('₹1.85L', 'Earned'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Info sections
            _SectionCard(
              title: 'Personal Details',
              items: [
                _InfoRow('Full Name', 'Amit Sharma'),
                _InfoRow('Email', 'amit.sharma@email.com'),
                _InfoRow('Date of Birth', '15/03/1995'),
                _InfoRow('Address', '45, Sector 22, Gurugram'),
              ],
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Vehicle Info',
              items: [
                _InfoRow('Type', 'Bike'),
                _InfoRow('Number', 'DL-01-AB-1234'),
                _InfoRow('Model', 'Honda CB Shine'),
              ],
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Documents',
              items: [
                _InfoRow('Aadhaar Card', 'Verified ✅'),
                _InfoRow('PAN Card', 'Verified ✅'),
                _InfoRow('Driving License', 'Verified ✅'),
              ],
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Bank Details',
              items: [
                _InfoRow('Bank', 'State Bank of India'),
                _InfoRow('Account', '******1234'),
                _InfoRow('IFSC', 'SBIN0001234'),
              ],
            ),
            const SizedBox(height: 24),

            // Menu items
            _MenuItem(
              icon: Icons.assignment,
              title: 'Onboarding',
              onTap: () => context.push('/partner/onboarding'),
            ),
            _MenuItem(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () => context.push('/partner/notifications'),
            ),
            _MenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () => context.push('/partner/support'),
            ),
            _MenuItem(
              icon: Icons.info,
              title: 'About',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  authController.logout();
                  context.go('/login');
                },
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: Text(
                  'Logout',
                  style: GoogleFonts.dmSans(color: AppColors.error, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label,
            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SectionCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...items,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
          Text(value,
              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo_final.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Text(controller.stepTitle)),
          ],
        ),
        leading: Obx(() => controller.currentStep.value > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: controller.previousStep,
              )
            : const SizedBox()),
      ),
      body: AppBackground(
        child: Column(
        children: [
          // Progress indicator
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: List.generate(controller.totalSteps, (index) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index <= controller.currentStep.value
                              ? AppColors.primary
                              : AppColors.divider,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              )),
          Expanded(
            child: Obx(() => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStep(controller.currentStep.value),
                )),
          ),
          // Next button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                    onPressed: () {
                      if (controller.currentStep.value == controller.totalSteps - 1) {
                        controller.nextStep();
                        context.go('/partner/home');
                      } else {
                        controller.nextStep();
                      }
                    },
                    child: Text(
                      controller.currentStep.value == controller.totalSteps - 1
                          ? 'Complete Setup'
                          : 'Continue',
                    ),
                  )),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return _PersonalDetailsStep(key: const ValueKey(0), controller: controller);
      case 1:
        return _DocumentUploadStep(key: const ValueKey(1), controller: controller);
      case 2:
        return _VehicleInfoStep(key: const ValueKey(2), controller: controller);
      case 3:
        return _BankDetailsStep(key: const ValueKey(3), controller: controller);
      default:
        return const SizedBox();
    }
  }
}

class _PersonalDetailsStep extends StatelessWidget {
  final OnboardingController controller;

  const _PersonalDetailsStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 48, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 24),
          _buildField('Full Name', 'Enter your full name',
              onChanged: (v) => controller.fullName.value = v),
          const SizedBox(height: 16),
          _buildField('Email Address', 'Enter your email',
              type: TextInputType.emailAddress,
              onChanged: (v) => controller.email.value = v),
          const SizedBox(height: 16),
          _buildField('Date of Birth', 'DD/MM/YYYY',
              onChanged: (v) => controller.dateOfBirth.value = v),
          const SizedBox(height: 16),
          _buildField('Address', 'Enter your full address',
              maxLines: 3,
              onChanged: (v) => controller.address.value = v),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint,
      {TextInputType? type, int maxLines = 1, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        TextField(
          keyboardType: type,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

class _DocumentUploadStep extends StatelessWidget {
  final OnboardingController controller;

  const _DocumentUploadStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload Required Documents',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('All documents will be verified within 24 hours',
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Obx(() => _DocumentCard(
                title: 'Aadhaar Card',
                subtitle: 'Front and back side',
                icon: Icons.credit_card,
                isUploaded: controller.aadharUploaded.value,
                onUpload: () => controller.mockUploadDocument('aadhar'),
              )),
          const SizedBox(height: 12),
          Obx(() => _DocumentCard(
                title: 'PAN Card',
                subtitle: 'Clear photo of PAN card',
                icon: Icons.badge,
                isUploaded: controller.panUploaded.value,
                onUpload: () => controller.mockUploadDocument('pan'),
              )),
          const SizedBox(height: 12),
          Obx(() => _DocumentCard(
                title: 'Driving License',
                subtitle: 'Valid driving license',
                icon: Icons.directions_car,
                isUploaded: controller.licenseUploaded.value,
                onUpload: () => controller.mockUploadDocument('license'),
              )),
        ],
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isUploaded;
  final VoidCallback onUpload;

  const _DocumentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isUploaded,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: (isUploaded ? AppColors.success : AppColors.primary).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isUploaded ? Icons.check_circle : icon,
            color: isUploaded ? AppColors.success : AppColors.primary,
          ),
        ),
        title: Text(title,
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
        subtitle: Text(
          isUploaded ? 'Uploaded ✓' : subtitle,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: isUploaded ? AppColors.success : AppColors.textSecondary,
          ),
        ),
        trailing: isUploaded
            ? null
            : OutlinedButton(
                onPressed: onUpload,
                child: const Text('Upload'),
              ),
      ),
    );
  }
}

class _VehicleInfoStep extends StatelessWidget {
  final OnboardingController controller;

  const _VehicleInfoStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.two_wheeler, size: 48, color: AppColors.accent),
            ),
          ),
          const SizedBox(height: 24),
          Text('Vehicle Type',
              style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Obx(() => Row(
                children: ['Bike', 'Scooter', 'EV Bike'].map((type) {
                  final selected = controller.vehicleType.value == type;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.vehicleType.value = type,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected ? AppColors.primary : AppColors.divider,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            type,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
          const SizedBox(height: 20),
          _buildField('Vehicle Number', 'e.g., DL-01-AB-1234',
              onChanged: (v) => controller.vehicleNumber.value = v),
          const SizedBox(height: 16),
          _buildField('Vehicle Model', 'e.g., Honda Activa 6G',
              onChanged: (v) => controller.vehicleModel.value = v),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint, {Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(onChanged: onChanged, decoration: InputDecoration(hintText: hint)),
      ],
    );
  }
}

class _BankDetailsStep extends StatelessWidget {
  final OnboardingController controller;

  const _BankDetailsStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_balance, size: 48, color: AppColors.info),
            ),
          ),
          const SizedBox(height: 24),
          _buildField('Bank Name', 'e.g., State Bank of India',
              onChanged: (v) => controller.bankName.value = v),
          const SizedBox(height: 16),
          _buildField('Account Holder Name', 'As per bank records',
              onChanged: (v) => controller.accountHolderName.value = v),
          const SizedBox(height: 16),
          _buildField('Account Number', 'Enter account number',
              type: TextInputType.number,
              onChanged: (v) => controller.accountNumber.value = v),
          const SizedBox(height: 16),
          _buildField('IFSC Code', 'e.g., SBIN0001234',
              onChanged: (v) => controller.ifscCode.value = v),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your bank details are secure and encrypted. Earnings will be deposited directly to this account.',
                    style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.info),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint,
      {TextInputType? type, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
            keyboardType: type,
            onChanged: onChanged,
            decoration: InputDecoration(hintText: hint)),
      ],
    );
  }
}

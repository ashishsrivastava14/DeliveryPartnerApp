import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/admin_controller.dart';
import '../../mock/mock_partners.dart';

class AdminPartnersScreen extends StatelessWidget {
  AdminPartnersScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Partner Management', style: GoogleFonts.poppins(fontSize: 18)),
      ),
      body: AppBackground(
        child: Column(
        children: [
          // Filters
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.surfaceDark,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final currentFilter = controller.partnerFilter.value;
                return Row(
                  children: [
                    _FilterChip('All', 'all', currentFilter, controller),
                    _FilterChip('Active', 'active', currentFilter, controller),
                    _FilterChip('Inactive', 'inactive', currentFilter, controller),
                    _FilterChip('Pending', 'pending', currentFilter, controller),
                    _FilterChip('Suspended', 'suspended', currentFilter, controller),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: Obx(() {
              final partners = controller.filteredPartners;
              if (partners.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people_outline, size: 64, color: Colors.white.withValues(alpha: 0.2)),
                      const SizedBox(height: 16),
                      Text('No partners found',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white54)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  final partner = partners[index];
                  return Card(
                    color: AppColors.cardDark,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => _showPartnerDetail(context, partner),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            _PartnerAvatar(partner: partner, size: 48),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(partner.name,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      _StatusBadge(partner.status),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${partner.id} • ${partner.zone} • ${partner.vehicleType}',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 13, color: Colors.white54),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text('${partner.totalOrders} orders',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 12, color: Colors.white38)),
                                      const SizedBox(width: 16),
                                      Text('⭐ ${partner.rating}',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 12, color: AppColors.accent)),
                                      const SizedBox(width: 16),
                                      Text('₹${(partner.totalEarnings / 1000).toStringAsFixed(1)}k',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 12, color: AppColors.success)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      ),
    );
  }

  void _showPartnerDetail(BuildContext context, MockPartner partner) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (ctx, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _PartnerAvatar(partner: partner, size: 60),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(partner.name,
                            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(partner.id,
                            style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white54)),
                      ],
                    ),
                  ),
                  _StatusBadge(partner.status),
                ],
              ),
              const SizedBox(height: 24),
              _DetailSection('Contact', [
                _DetailRow('Phone', partner.phone),
                _DetailRow('Email', partner.email),
              ]),
              _DetailSection('Vehicle', [
                _DetailRow('Type', partner.vehicleType),
                _DetailRow('Number', partner.vehicleNumber),
              ]),
              _DetailSection('Performance', [
                _DetailRow('Total Orders', '${partner.totalOrders}'),
                _DetailRow('Rating', '${partner.rating} ⭐'),
                _DetailRow('Total Earnings', '₹${partner.totalEarnings.toStringAsFixed(0)}'),
                _DetailRow('Joined', partner.joinDate),
              ]),
              _DetailSection('Documents', [
                _DetailRow('Status', partner.documentStatus.toUpperCase()),
              ]),
              const SizedBox(height: 16),
              // Actions
              Row(
                children: [
                  if (partner.documentStatus == 'pending') ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                        child: const Text('Approve Docs'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                  ],
                  if (partner.status == 'active')
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                        ),
                        child: const Text('Suspend Partner'),
                      ),
                    ),
                  if (partner.status == 'suspended')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                        child: const Text('Reactivate Partner'),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String currentFilter;
  final AdminController controller;

  const _FilterChip(this.label, this.value, this.currentFilter, this.controller);

  @override
  Widget build(BuildContext context) {
    final selected = currentFilter == value;
    return GestureDetector(
      onTap: () => controller.setPartnerFilter(value),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.white54,
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'active':
        color = AppColors.success;
        break;
      case 'inactive':
        color = AppColors.textSecondary;
        break;
      case 'pending':
        color = AppColors.accent;
        break;
      case 'suspended':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailSection(this.title, this.children);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.white54)),
          Text(value, style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }
}

class _PartnerAvatar extends StatelessWidget {
  final MockPartner partner;
  final double size;

  const _PartnerAvatar({required this.partner, required this.size});

  @override
  Widget build(BuildContext context) {
    final fontSize = size * 0.38;
    if (partner.profileImage.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          partner.profileImage,
          width: size,
          height: size,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _Placeholder(name: partner.name, size: size, fontSize: fontSize);
          },
          errorBuilder: (context, _, __) =>
              _Placeholder(name: partner.name, size: size, fontSize: fontSize),
        ),
      );
    }
    return _Placeholder(name: partner.name, size: size, fontSize: fontSize);
  }
}

class _Placeholder extends StatelessWidget {
  final String name;
  final double size;
  final double fontSize;

  const _Placeholder({required this.name, required this.size, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        name[0],
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

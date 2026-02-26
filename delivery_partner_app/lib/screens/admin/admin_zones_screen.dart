import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../controllers/admin_controller.dart';

class AdminZonesScreen extends StatelessWidget {
  AdminZonesScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Zone & City Management', style: GoogleFonts.poppins(fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddZoneDialog(context),
          ),
        ],
      ),
      body: AppBackground(
        child: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.zones.length,
            itemBuilder: (context, index) {
              final zone = controller.zones[index];
              return Card(
                color: AppColors.cardDark,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(zone.color).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.location_on, color: Color(zone.color)),
                  ),
                  title: Row(
                    children: [
                      Text(zone.name,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                      const SizedBox(width: 8),
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: zone.isActive ? AppColors.success : AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${zone.city} • ${zone.activePartners} active partners',
                          style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white54)),
                    ],
                  ),
                  trailing: Switch(
                    value: zone.isActive,
                    onChanged: (_) => controller.toggleZone(zone.id),
                    activeThumbColor: AppColors.primary,
                  ),
                ),
              );
            },
          )),
      ),
    );
  }

  void _showAddZoneDialog(BuildContext context) {
    final nameC = TextEditingController();
    final cityC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Add New Zone', style: GoogleFonts.poppins(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameC,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'Zone name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cityC,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'City'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.dmSans(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Zone added successfully'), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Add Zone'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// "Powered by QuickPrepAI" footer widget shown app-wide.
class PoweredByQuickPrepAI extends StatelessWidget {
  /// Use [light] for dark backgrounds (white text), dark for light backgrounds.
  final bool light;

  const PoweredByQuickPrepAI({super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by ',
            style: GoogleFonts.dmSans(
              fontSize: 11,
              color: light ? Colors.white54 : AppColors.textSecondary,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              'assets/images/QuickPrepAI_logo.png',
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 4),
          // Text(
          //   'QuickPrepAI',
          //   style: GoogleFonts.poppins(
          //     fontSize: 11,
          //     fontWeight: FontWeight.w600,
          //     color: light ? Colors.white70 : AppColors.textPrimary,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AppWidgets {
  static Widget shimmerLoading({
    double width = double.infinity,
    double height = 60,
    double borderRadius = 12,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  static Widget emptyState({
    required String title,
    required String subtitle,
    IconData icon = Icons.inbox_outlined,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 56, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget statusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  static Widget kpiCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
  }) {
    return Card(
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
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

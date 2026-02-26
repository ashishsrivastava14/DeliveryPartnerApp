import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';
import '../../mock/mock_notifications.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(title: const Text('Notifications')),
      body: AppBackground(
        child: MockNotifications.allNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 64, color: AppColors.primary.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text('No notifications',
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text('You\'re all caught up!',
                      style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MockNotifications.allNotifications.length,
              itemBuilder: (context, index) {
                final notif = MockNotifications.allNotifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: notif.isRead ? Colors.white : AppColors.primary.withValues(alpha: 0.03),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _typeColor(notif.type).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(_typeIcon(notif.type),
                          color: _typeColor(notif.type), size: 22),
                    ),
                    title: Text(
                      notif.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: notif.isRead ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(notif.body,
                            style: GoogleFonts.dmSans(
                                fontSize: 13, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Text(
                          _timeAgo(notif.time),
                          style: GoogleFonts.dmSans(
                              fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    trailing: !notif.isRead
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'order': return AppColors.primary;
      case 'incentive': return AppColors.accent;
      case 'document': return AppColors.info;
      case 'penalty': return AppColors.error;
      case 'system': return AppColors.textSecondary;
      default: return AppColors.textSecondary;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'order': return Icons.delivery_dining;
      case 'incentive': return Icons.emoji_events;
      case 'document': return Icons.description;
      case 'penalty': return Icons.warning;
      case 'system': return Icons.info;
      default: return Icons.notifications;
    }
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class MockNotification {
  final String id;
  final String title;
  final String body;
  final String type; // order, incentive, document, penalty, system
  final DateTime time;
  final bool isRead;

  MockNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.time,
    this.isRead = false,
  });
}

class MockZone {
  final String id;
  final String name;
  final String city;
  final int activePartners;
  final bool isActive;
  final int color;

  MockZone({
    required this.id,
    required this.name,
    required this.city,
    required this.activePartners,
    required this.isActive,
    required this.color,
  });
}

class MockNotifications {
  static List<MockNotification> allNotifications = [
    MockNotification(id: '1', title: 'New Order Available', body: 'A new order from FreshMart Superstore is waiting for you!', type: 'order', time: DateTime.now().subtract(const Duration(minutes: 5))),
    MockNotification(id: '2', title: 'Incentive Unlocked! 🎉', body: 'You completed the Streak Master challenge! ₹150 bonus added.', type: 'incentive', time: DateTime.now().subtract(const Duration(hours: 1))),
    MockNotification(id: '3', title: 'Document Approved', body: 'Your driving license has been verified and approved.', type: 'document', time: DateTime.now().subtract(const Duration(hours: 3)), isRead: true),
    MockNotification(id: '4', title: 'Late Delivery Penalty', body: 'A penalty of ₹15 was applied for late delivery on ORD-10230.', type: 'penalty', time: DateTime.now().subtract(const Duration(hours: 5)), isRead: true),
    MockNotification(id: '5', title: 'Peak Hours Active! 🔥', body: 'Earn 1.5x on all deliveries from 12 PM to 3 PM today.', type: 'system', time: DateTime.now().subtract(const Duration(hours: 8))),
    MockNotification(id: '6', title: 'Weekly Report Ready', body: 'Your weekly earnings report is now available. Total: ₹3,250', type: 'system', time: DateTime.now().subtract(const Duration(days: 1)), isRead: true),
    MockNotification(id: '7', title: 'New Order Available', body: 'Order from QuickBasket - 3 items, 2.1 km away.', type: 'order', time: DateTime.now().subtract(const Duration(days: 1))),
    MockNotification(id: '8', title: 'Profile Update Reminder', body: 'Please update your bank details for faster payouts.', type: 'system', time: DateTime.now().subtract(const Duration(days: 2)), isRead: true),
  ];
}

class MockZones {
  static List<MockZone> allZones = [
    MockZone(id: 'Z-01', name: 'South Delhi', city: 'Delhi', activePartners: 45, isActive: true, color: 0xFF1A6B3C),
    MockZone(id: 'Z-02', name: 'North Delhi', city: 'Delhi', activePartners: 38, isActive: true, color: 0xFF3B82F6),
    MockZone(id: 'Z-03', name: 'East Delhi', city: 'Delhi', activePartners: 22, isActive: true, color: 0xFFF59E0B),
    MockZone(id: 'Z-04', name: 'West Delhi', city: 'Delhi', activePartners: 30, isActive: true, color: 0xFFEF4444),
    MockZone(id: 'Z-05', name: 'Gurugram', city: 'Haryana', activePartners: 55, isActive: true, color: 0xFF8B5CF6),
    MockZone(id: 'Z-06', name: 'Noida', city: 'UP', activePartners: 40, isActive: true, color: 0xFF06B6D4),
    MockZone(id: 'Z-07', name: 'Faridabad', city: 'Haryana', activePartners: 18, isActive: false, color: 0xFF84CC16),
    MockZone(id: 'Z-08', name: 'Ghaziabad', city: 'UP', activePartners: 12, isActive: false, color: 0xFFEC4899),
  ];
}

class EarningEntry {
  final String label;
  final double amount;
  final String type; // base, incentive, tip, penalty
  final DateTime date;
  final String? orderId;

  EarningEntry({
    required this.label,
    required this.amount,
    required this.type,
    required this.date,
    this.orderId,
  });
}

class IncentivePlan {
  final String id;
  final String title;
  final String description;
  final int targetOrders;
  final int completedOrders;
  final double bonusAmount;
  final bool isActive;

  IncentivePlan({
    required this.id,
    required this.title,
    required this.description,
    required this.targetOrders,
    required this.completedOrders,
    required this.bonusAmount,
    required this.isActive,
  });

  double get progress => completedOrders / targetOrders;
}

class PayoutRequest {
  final String id;
  final String partnerId;
  final String partnerName;
  final double amount;
  final String status; // pending, approved, rejected
  final DateTime requestDate;

  PayoutRequest({
    required this.id,
    required this.partnerId,
    required this.partnerName,
    required this.amount,
    required this.status,
    required this.requestDate,
  });
}

class MockEarnings {
  static double get todayEarnings => 485.0;
  static double get weekEarnings => 3250.0;
  static double get monthEarnings => 12800.0;
  static double get totalEarnings => 185000.0;
  static double get availableBalance => 2450.0;

  static List<EarningEntry> get earningBreakdown => [
    EarningEntry(label: 'Base Pay', amount: 320.0, type: 'base', date: DateTime.now()),
    EarningEntry(label: 'Distance Bonus', amount: 85.0, type: 'base', date: DateTime.now()),
    EarningEntry(label: 'Peak Hour Incentive', amount: 50.0, type: 'incentive', date: DateTime.now()),
    EarningEntry(label: 'Customer Tips', amount: 45.0, type: 'tip', date: DateTime.now()),
    EarningEntry(label: 'Late Delivery Penalty', amount: -15.0, type: 'penalty', date: DateTime.now()),
  ];

  static List<EarningEntry> get transactionHistory => [
    EarningEntry(label: 'Order ORD-10234', amount: 45.0, type: 'base', date: DateTime.now().subtract(const Duration(hours: 1)), orderId: 'ORD-10234'),
    EarningEntry(label: 'Order ORD-10235', amount: 35.0, type: 'base', date: DateTime.now().subtract(const Duration(hours: 2)), orderId: 'ORD-10235'),
    EarningEntry(label: 'Peak Hour Bonus', amount: 50.0, type: 'incentive', date: DateTime.now().subtract(const Duration(hours: 3))),
    EarningEntry(label: 'Order ORD-10237', amount: 75.0, type: 'base', date: DateTime.now().subtract(const Duration(hours: 4)), orderId: 'ORD-10237'),
    EarningEntry(label: 'Customer Tip', amount: 20.0, type: 'tip', date: DateTime.now().subtract(const Duration(hours: 5))),
    EarningEntry(label: 'Order ORD-10238', amount: 52.0, type: 'base', date: DateTime.now().subtract(const Duration(hours: 6)), orderId: 'ORD-10238'),
    EarningEntry(label: 'Withdrawal', amount: -500.0, type: 'base', date: DateTime.now().subtract(const Duration(days: 1))),
    EarningEntry(label: 'Late Penalty', amount: -15.0, type: 'penalty', date: DateTime.now().subtract(const Duration(days: 1))),
    EarningEntry(label: 'Referral Bonus', amount: 200.0, type: 'incentive', date: DateTime.now().subtract(const Duration(days: 2))),
    EarningEntry(label: 'Order ORD-10240', amount: 30.0, type: 'base', date: DateTime.now().subtract(const Duration(days: 2)), orderId: 'ORD-10240'),
  ];

  static List<IncentivePlan> get incentivePlans => [
    IncentivePlan(id: 'INC-01', title: 'Daily Champion', description: 'Complete 10 orders today', targetOrders: 10, completedOrders: 7, bonusAmount: 200, isActive: true),
    IncentivePlan(id: 'INC-02', title: 'Weekend Warrior', description: 'Complete 25 orders this weekend', targetOrders: 25, completedOrders: 12, bonusAmount: 500, isActive: true),
    IncentivePlan(id: 'INC-03', title: 'Streak Master', description: 'Deliver 5 consecutive orders without rejection', targetOrders: 5, completedOrders: 5, bonusAmount: 150, isActive: false),
    IncentivePlan(id: 'INC-04', title: 'Peak Performer', description: 'Complete 8 orders during peak hours (12-3 PM)', targetOrders: 8, completedOrders: 3, bonusAmount: 300, isActive: true),
  ];

  static List<PayoutRequest> get payoutRequests => [
    PayoutRequest(id: 'PAY-001', partnerId: 'DP-001', partnerName: 'Amit Sharma', amount: 5000, status: 'pending', requestDate: DateTime.now().subtract(const Duration(hours: 2))),
    PayoutRequest(id: 'PAY-002', partnerId: 'DP-002', partnerName: 'Rajesh Kumar', amount: 3000, status: 'pending', requestDate: DateTime.now().subtract(const Duration(hours: 5))),
    PayoutRequest(id: 'PAY-003', partnerId: 'DP-006', partnerName: 'Manoj Tiwari', amount: 8000, status: 'approved', requestDate: DateTime.now().subtract(const Duration(days: 1))),
    PayoutRequest(id: 'PAY-004', partnerId: 'DP-007', partnerName: 'Pradeep Yadav', amount: 2000, status: 'rejected', requestDate: DateTime.now().subtract(const Duration(days: 2))),
  ];

  static List<double> get dailyOrdersThisWeek => [45, 52, 38, 61, 55, 70, 48];
  static List<double> get earningsTrend => [2100, 2400, 1800, 3200, 2900, 3500, 2800];
  static List<String> get weekDays => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}

import 'package:get/get.dart';
import '../mock/mock_partners.dart';
import '../mock/mock_orders.dart';
import '../mock/mock_earnings.dart';
import '../mock/mock_notifications.dart';

class AdminController extends GetxController {
  final selectedNavIndex = 0.obs;

  // Dashboard
  int get activePartnersCount => MockPartners.activePartners.length;
  int get totalOrdersToday => MockOrders.todayOrders.length;
  double get avgDeliveryTime => 22.5;
  double get totalEarningsPaidOut => 185000;

  List<double> get dailyOrders => MockEarnings.dailyOrdersThisWeek;
  List<double> get earningsTrend => MockEarnings.earningsTrend;
  List<String> get weekDays => MockEarnings.weekDays;

  // Partner Management
  final partnerFilter = 'all'.obs;
  List<MockPartner> get allPartners => MockPartners.allPartners;

  List<MockPartner> get filteredPartners {
    if (partnerFilter.value == 'all') return allPartners;
    return allPartners.where((p) => p.status == partnerFilter.value).toList();
  }

  void setPartnerFilter(String filter) {
    partnerFilter.value = filter;
  }

  // Order Management
  List<MockOrder> get allOrders => MockOrders.allOrders;
  final selectedPartnerForAssign = ''.obs;

  // Payouts
  final payoutRequests = MockEarnings.payoutRequests.obs;

  void approvePayout(String payoutId) {
    final index = payoutRequests.indexWhere((p) => p.id == payoutId);
    if (index >= 0) {
      final old = payoutRequests[index];
      payoutRequests[index] = PayoutRequest(
        id: old.id,
        partnerId: old.partnerId,
        partnerName: old.partnerName,
        amount: old.amount,
        status: 'approved',
        requestDate: old.requestDate,
      );
      payoutRequests.refresh();
    }
  }

  void rejectPayout(String payoutId) {
    final index = payoutRequests.indexWhere((p) => p.id == payoutId);
    if (index >= 0) {
      final old = payoutRequests[index];
      payoutRequests[index] = PayoutRequest(
        id: old.id,
        partnerId: old.partnerId,
        partnerName: old.partnerName,
        amount: old.amount,
        status: 'rejected',
        requestDate: old.requestDate,
      );
      payoutRequests.refresh();
    }
  }

  // Incentive plans management
  final incentivePlans = MockEarnings.incentivePlans.obs;

  void deleteIncentive(String id) {
    incentivePlans.removeWhere((p) => p.id == id);
  }

  void addIncentive(IncentivePlan plan) {
    incentivePlans.add(plan);
  }

  // Zones
  final zones = MockZones.allZones.obs;

  void toggleZone(String id) {
    final index = zones.indexWhere((z) => z.id == id);
    if (index >= 0) {
      final old = zones[index];
      zones[index] = MockZone(
        id: old.id,
        name: old.name,
        city: old.city,
        activePartners: old.activePartners,
        isActive: !old.isActive,
        color: old.color,
      );
      zones.refresh();
    }
  }

  // Notifications / Broadcasts
  final broadcastHistory = <Map<String, String>>[
    {'title': 'Peak Hours Active', 'target': 'All Partners', 'date': '2025-02-25'},
    {'title': 'New Zone Launched', 'target': 'Gurugram', 'date': '2025-02-20'},
    {'title': 'Holiday Bonus', 'target': 'All Partners', 'date': '2025-02-15'},
  ].obs;

  void sendBroadcast(Map<String, String> broadcast) {
    broadcastHistory.insert(0, broadcast);
  }

  // Settings
  final otpVerificationEnabled = true.obs;
  final autoAssignEnabled = true.obs;
  final surgePricingEnabled = false.obs;
}

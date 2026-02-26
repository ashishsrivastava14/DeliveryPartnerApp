import 'dart:async';
import 'package:get/get.dart';
import '../mock/mock_orders.dart';
import '../mock/mock_earnings.dart';

class PartnerHomeController extends GetxController {
  final isOnline = false.obs;
  final todayEarnings = 485.0.obs;
  final ordersDelivered = 7.obs;
  final distanceCovered = 28.5.obs;
  final hasActiveOrder = true.obs;
  final bottomNavIndex = 0.obs;

  // Order flow
  final showNewOrderAlert = false.obs;
  final orderCountdown = 30.obs;
  final currentOrderStep = 0.obs; // 0=Assigned, 1=ReachedStore, 2=PickedUp, 3=EnRoute, 4=Delivered
  final orderOtp = ''.obs;
  final isOrderCompleted = false.obs;
  Timer? _countdownTimer;

  MockOrder get activeOrder => MockOrders.activeOrder;
  MockOrder get newOrder => MockOrders.newOrderAlert;
  List<MockOrder> get todayOrders => MockOrders.todayOrders;
  List<MockOrder> get weekOrders => MockOrders.weekOrders;
  List<MockOrder> get allOrders => MockOrders.allOrders;

  // Earnings
  double get availableBalance => MockEarnings.availableBalance;
  List<EarningEntry> get earningBreakdown => MockEarnings.earningBreakdown;
  List<EarningEntry> get transactions => MockEarnings.transactionHistory;
  List<IncentivePlan> get incentives => MockEarnings.incentivePlans;

  void toggleOnline() {
    isOnline.value = !isOnline.value;
    if (isOnline.value) {
      // Simulate new order alert after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (isOnline.value) {
          triggerNewOrderAlert();
        }
      });
    }
  }

  void triggerNewOrderAlert() {
    showNewOrderAlert.value = true;
    orderCountdown.value = 30;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (orderCountdown.value > 0) {
        orderCountdown.value--;
      } else {
        rejectOrder();
      }
    });
  }

  void acceptOrder() {
    _countdownTimer?.cancel();
    showNewOrderAlert.value = false;
    hasActiveOrder.value = true;
    currentOrderStep.value = 0;
    isOrderCompleted.value = false;
  }

  void rejectOrder() {
    _countdownTimer?.cancel();
    showNewOrderAlert.value = false;
  }

  void advanceOrderStep() {
    if (currentOrderStep.value < 4) {
      currentOrderStep.value++;
      if (currentOrderStep.value == 4) {
        isOrderCompleted.value = true;
        hasActiveOrder.value = false;
        ordersDelivered.value++;
        todayEarnings.value += 55.0;
      }
    }
  }

  bool verifyDeliveryOtp(String enteredOtp) {
    return enteredOtp == '1234';
  }

  void completeOrderFlow() {
    isOrderCompleted.value = false;
    currentOrderStep.value = 0;
  }

  String get currentStepLabel {
    switch (currentOrderStep.value) {
      case 0:
        return 'Assigned';
      case 1:
        return 'Reached Store';
      case 2:
        return 'Picked Up';
      case 3:
        return 'En Route';
      case 4:
        return 'Delivered';
      default:
        return '';
    }
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }
}

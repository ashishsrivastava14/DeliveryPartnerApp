import 'dart:async';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final otp = ''.obs;
  final isOtpSent = false.obs;
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final selectedRole = ''.obs; // 'partner' or 'admin'
  Timer? _otpTimer;

  void sendOtp() {
    if (phoneNumber.value.length < 10) return;
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      isOtpSent.value = true;
      // Auto-fill OTP after 3 seconds
      _otpTimer = Timer(const Duration(seconds: 3), () {
        otp.value = '1234';
      });
    });
  }

  void verifyOtp() {
    if (otp.value == '1234') {
      isLoggedIn.value = true;
    }
  }

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void logout() {
    isLoggedIn.value = false;
    selectedRole.value = '';
    phoneNumber.value = '';
    otp.value = '';
    isOtpSent.value = false;
  }

  @override
  void onClose() {
    _otpTimer?.cancel();
    super.onClose();
  }
}

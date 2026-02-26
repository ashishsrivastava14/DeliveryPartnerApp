import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final currentStep = 0.obs;
  final totalSteps = 4;

  // Personal Details
  final fullName = ''.obs;
  final email = ''.obs;
  final dateOfBirth = ''.obs;
  final address = ''.obs;

  // Documents
  final aadharUploaded = false.obs;
  final panUploaded = false.obs;
  final licenseUploaded = false.obs;

  // Vehicle Info
  final vehicleType = 'Bike'.obs;
  final vehicleNumber = ''.obs;
  final vehicleModel = ''.obs;

  // Bank Details
  final bankName = ''.obs;
  final accountNumber = ''.obs;
  final ifscCode = ''.obs;
  final accountHolderName = ''.obs;

  final isProfileComplete = false.obs;
  final isEditMode = false.obs;

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      isProfileComplete.value = true;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void mockUploadDocument(String type) {
    switch (type) {
      case 'aadhar':
        aadharUploaded.value = true;
        break;
      case 'pan':
        panUploaded.value = true;
        break;
      case 'license':
        licenseUploaded.value = true;
        break;
    }
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  String get stepTitle {
    switch (currentStep.value) {
      case 0:
        return 'Personal Details';
      case 1:
        return 'Upload Documents';
      case 2:
        return 'Vehicle Information';
      case 3:
        return 'Bank Details';
      default:
        return '';
    }
  }
}

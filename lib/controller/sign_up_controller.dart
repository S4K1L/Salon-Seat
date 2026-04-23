import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/data/model/otp_route_args.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final businessNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final agreeToTerms = false.obs;
  final isLoading = false.obs;

  void toggleTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  Future<void> submit(GlobalKey<FormState> formKey, AppUserRole role) async {
    if (!agreeToTerms.value) {
      Get.showSnackbar(
        const GetSnackBar(
          messageText: Text(
            'Please accept the Terms of Service and Privacy Policy',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: Colors.black87,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(12),
          borderRadius: 8,
        ),
      );
      return;
    }
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;

    final email = emailController.text.trim();
    final afterVerification = role == AppUserRole.beautyProfessional
        ? OtpAfterVerification.beautyProfileSetup
        : OtpAfterVerification.listingPlan;
    Get.offNamed(
      AppRoutes.otpScreen,
      arguments: OtpRouteArgs(
        email: email,
        purpose: OtpPurpose.signUp,
        afterVerification: afterVerification,
      ),
    );
  }

  void openTerms() {
    Get.showSnackbar(
      const GetSnackBar(
        messageText: Text(
          'Terms of Service — coming soon',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
      ),
    );
  }

  void openPrivacy() {
    Get.showSnackbar(
      const GetSnackBar(
        messageText: Text(
          'Privacy Policy — coming soon',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
      ),
    );
  }

  @override
  void onClose() {
    businessNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

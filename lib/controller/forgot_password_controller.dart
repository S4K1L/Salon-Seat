import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/otp_route_args.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  final isLoading = false.obs;

  Future<void> sendOtp(GlobalKey<FormState> formKey) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;

    final email = emailController.text.trim();
    Get.toNamed(
      AppRoutes.otpScreen,
      arguments: OtpRouteArgs(
        email: email,
        purpose: OtpPurpose.forgotPassword,
      ),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

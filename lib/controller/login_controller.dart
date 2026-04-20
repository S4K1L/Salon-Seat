import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final rememberMe = false.obs;
  final isLoading = false.obs;

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  Future<void> submit(GlobalKey<FormState> formKey) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  void onForgotPassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
  }

  void onGoogle() {
    Get.showSnackbar(
      const GetSnackBar(
        messageText: Text(
          'Google sign-in coming soon',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(12),
        borderRadius: 8,
      ),
    );
  }

  void onFacebook() {
    Get.showSnackbar(
      const GetSnackBar(
        messageText: Text(
          'Facebook sign-in coming soon',
          style: TextStyle(color: Colors.white),
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

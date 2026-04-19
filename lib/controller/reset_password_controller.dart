import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordController({required this.email});

  final String email;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> submit(GlobalKey<FormState> formKey) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.chooseRoleScreen);
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

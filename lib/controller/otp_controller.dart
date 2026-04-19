import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extension/data/model/otp_route_args.dart';
import 'package:flutter_extension/data/model/reset_password_route_args.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  final secondsRemaining = 45.obs;
  final isLoading = false.obs;

  late final String email;
  late final OtpPurpose purpose;
  late final OtpRouteArgs _args;

  Timer? _timer;

  static const int _initialSeconds = 45;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is OtpRouteArgs) {
      _args = args;
      email = args.email;
      purpose = args.purpose;
    } else {
      _args = const OtpRouteArgs(email: '');
      email = '';
      purpose = OtpPurpose.signUp;
    }
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    secondsRemaining.value = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining.value <= 0) {
        t.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  bool get canResend => secondsRemaining.value <= 0;

  Future<void> resend() async {
    if (!canResend) return;
    otpController.clear();
    _startTimer();
    Get.showSnackbar(
      const GetSnackBar(
        messageText: Text(
          'Verification code sent again',
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

  Future<void> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final raw = data?.text ?? '';
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return;
    otpController.text = digits.length > 6 ? digits.substring(0, 6) : digits;
    otpController.selection = TextSelection.collapsed(
      offset: otpController.text.length,
    );
  }

  void _navigateAfterVerification() {
    switch (_args.resolvedAfterVerification) {
      case OtpAfterVerification.login:
        Get.offAllNamed(AppRoutes.loginScreen);
        break;
      case OtpAfterVerification.home:
        Get.offAllNamed(AppRoutes.homeScreen);
        break;
      case OtpAfterVerification.resetPassword:
        Get.offAllNamed(
          AppRoutes.resetPasswordScreen,
          arguments: ResetPasswordRouteArgs(email: email),
        );
        break;
      case OtpAfterVerification.listingPlan:
        Get.offAllNamed(AppRoutes.listingPlanScreen);
        break;
    }
  }

  Future<void> confirm() async {
    if (otpController.text.length != 6) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
    _navigateAfterVerification();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}

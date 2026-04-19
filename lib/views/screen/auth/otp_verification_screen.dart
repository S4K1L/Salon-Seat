import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extension/controller/otp_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/mask_email.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final OtpController _c;
  late final VoidCallback _otpListener;

  @override
  void initState() {
    super.initState();
    _c = Get.find<OtpController>();
    _otpListener = () => setState(() {});
    _c.otpController.addListener(_otpListener);
  }

  @override
  void dispose() {
    _c.otpController.removeListener(_otpListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = _c.otpController.text;
    final masked = maskEmail(_c.email);

    return Scaffold(
      backgroundColor: AppColors.otpBackground,
      body: SafeArea(
        child: AutofillGroup(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.sp,
                      color: AppColors.authTextSecondary,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Enter OTP Code',
                        style: AppFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 24.sp,
                      color: AppColors.authTextSecondary,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Enter The OTP code we just emailed to you. Make sure to check your spam folder if you don\'t see it.',
                  style: AppFonts.inter(
                    fontSize: 14.sp,
                    height: 1.45,
                    color: AppColors.authTextSecondary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text.rich(
                  TextSpan(
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.authTextPrimary,
                    ),
                    children: [
                      const TextSpan(text: 'Code has been sent to '),
                      TextSpan(
                        text: masked,
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.signUpPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _OtpInputRow(controller: _c),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _c.pasteFromClipboard,
                    child: Text(
                      'Paste code',
                      style: AppFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.signUpPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(
                  () {
                    final s = _c.secondsRemaining.value;
                    final canResend = s <= 0;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.authBorder,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: !canResend
                                  ? Text.rich(
                                      TextSpan(
                                        style: AppFonts.inter(
                                          fontSize: 13.sp,
                                          color: AppColors.authTextSecondary,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Resend Code in '),
                                          TextSpan(
                                            text: '$s s',
                                            style: AppFonts.inter(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.signUpPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      'Didn\'t get the code?',
                                      style: AppFonts.inter(
                                        fontSize: 13.sp,
                                        color: AppColors.authTextSecondary,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.authBorder,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        Center(
                          child: GestureDetector(
                            onTap: canResend ? _c.resend : null,
                            child: Text.rich(
                              TextSpan(
                                style: AppFonts.inter(
                                  fontSize: 14.sp,
                                  color: AppColors.authTextSecondary,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Didn\'t receive code? ',
                                  ),
                                  TextSpan(
                                    text: 'Resend it',
                                    style: AppFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: canResend
                                          ? AppColors.signUpPrimary
                                          : AppColors.authHint,
                                      decoration: canResend
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 32.h),
                Obx(
                  () => PrimaryFilledButton(
                    label: 'Confirm',
                    loading: _c.isLoading.value,
                    enabled: code.length == 6 && !_c.isLoading.value,
                    onPressed: code.length == 6 ? _c.confirm : null,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpInputRow extends StatelessWidget {
  const _OtpInputRow({required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    final code = controller.otpController.text;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.focusNode.requestFocus(),
      child: SizedBox(
        height: 52.h,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: TextField(
                controller: controller.otpController,
                focusNode: controller.focusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                enableSuggestions: false,
                autocorrect: false,
                autofillHints: const [AutofillHints.oneTimeCode],
                cursorColor: Colors.transparent,
                showCursor: false,
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 1.sp,
                  height: 0.01,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
              ),
            ),
            IgnorePointer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  final has = i < code.length;
                  final ch = has ? code.substring(i, i + 1) : null;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.authFieldFill,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.authBorder),
                          ),
                          child: Text(
                            has ? ch! : '—',
                            style: AppFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: has
                                  ? AppColors.authTextPrimary
                                  : AppColors.authHint,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

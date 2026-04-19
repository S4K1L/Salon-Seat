import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/reset_password_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/auth_form_field.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ResetPasswordController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<ResetPasswordController>();
  }

  String? _password(String? v) {
    if (v == null || v.isEmpty) return 'Please enter a password';
    if (v.length < 8) return 'Minimum 8 characters';
    return null;
  }

  String? _confirm(String? v) {
    if (v == null || v.isEmpty) return 'Please re-type your password';
    if (v != _c.passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, top: 4.h, right: 8.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.offAllNamed(AppRoutes.loginScreen),
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18.sp,
                            color: AppColors.authTextSecondary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Back',
                            style: AppFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.authTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 8.h),
                      Center(
                        child: Image.asset(
                          Images.logo,
                          width: 72.w,
                          height: 72.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Reset Password',
                        style: AppFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enter a new password',
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.authTextSecondary,
                          height: 1.35,
                        ),
                      ),
                      SizedBox(height: 28.h),
                      AuthFormField(
                        label: 'New Password',
                        controller: _c.passwordController,
                        prefixSvgPath: Images.icLock,
                        hintText: 'Enter New password',
                        obscure: true,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.newPassword],
                        validator: _password,
                      ),
                      SizedBox(height: 14.h),
                      AuthFormField(
                        label: 'Re-type Password',
                        controller: _c.confirmPasswordController,
                        prefixSvgPath: Images.icLock,
                        hintText: 'Re-type Password',
                        obscure: true,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.newPassword],
                        validator: _confirm,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                child: Obx(
                  () => PrimaryFilledButton(
                    label: 'Reset Password',
                    loading: _c.isLoading.value,
                    onPressed: () => _c.submit(_formKey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

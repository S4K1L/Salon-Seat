import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/forgot_password_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/auth_form_field.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ForgotPasswordController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<ForgotPasswordController>();
  }

  String? _validateEmail(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your email';
    if (!GetUtils.isEmail(s)) return 'Please enter a valid email';
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
                    onTap: () => Get.back(),
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
                        'Forget Your Password 🔑',
                        textAlign: TextAlign.center,
                        style: AppFonts.inter(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No worries. We\'ll help you reset it. Enter your '
                        'registered email address and we\'ll send you a 6 digit '
                        'code to verify your identity.',
                        textAlign: TextAlign.center,
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.authTextSecondary,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 28.h),
                      AuthFormField(
                        label: 'Email',
                        controller: _c.emailController,
                        prefixSvgPath: Images.icEmail,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.email],
                        validator: _validateEmail,
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
                    label: 'Send OTP Code',
                    loading: _c.isLoading.value,
                    onPressed: () => _c.sendOtp(_formKey),
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

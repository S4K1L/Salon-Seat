import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/controller/sign_up_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/auth_form_field.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final SignUpController _c;

  static const _accent = AppColors.signUpPrimary;

  AppUserRole get _role {
    final a = Get.arguments;
    if (a is AppUserRole) return a;
    return AppUserRole.salonOwner;
  }

  String get _roleTitle {
    switch (_role) {
      case AppUserRole.beautyProfessional:
        return 'Beauty Professional';
      case AppUserRole.salonOwner:
        return 'Salon Owner';
    }
  }

  @override
  void initState() {
    super.initState();
    _c = Get.find<SignUpController>();
  }

  String? _required(String? v, String label) {
    if (v == null || v.trim().isEmpty) return 'Please enter $label';
    return null;
  }

  String? _email(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your email';
    if (!GetUtils.isEmail(s)) return 'Please enter a valid email';
    return null;
  }

  String? _password(String? v) {
    if (v == null || v.isEmpty) return 'Please enter a password';
    if (v.length < 8) return 'Minimum 8 characters';
    return null;
  }

  String? _confirm(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16.sp,
                            color: AppColors.authTextSecondary,
                          ),
                          SizedBox(width: 4.w),
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
                SizedBox(height: 12.h),
                Text(
                  'Create Account',
                  style: AppFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.authTextPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    style: AppFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.authTextSecondary,
                      height: 1.35,
                    ),
                    children: [
                      const TextSpan(text: 'Sign up as a '),
                      TextSpan(
                        text: _roleTitle,
                        style: AppFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: _accent,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                if(_role == AppUserRole.salonOwner)...[
                  AuthFormField(
                  label: 'Business Name',
                  controller: _c.businessNameController,
                  hintText: 'Enter business name',
                  textInputAction: TextInputAction.next,
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: (v) => _required(v, 'business name'),
                ),
                SizedBox(height: 16.h),
                AuthFormField(
                  label: 'Business Address',
                  controller: _c.addressController,
                  hintText: 'Street Address Field',
                  textInputAction: TextInputAction.next,
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: (v) => _required(v, 'business address'),
                ),
                SizedBox(height: 16.h),
                AuthFormField(
                  label: 'City',
                  controller: _c.cityController,
                  hintText: 'Enter city name',
                  textInputAction: TextInputAction.next,
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: (v) => _required(v, 'city'),
                ),
                SizedBox(height: 16.h),
                AuthFormField(
                  label: 'ZIP Code',
                  controller: _c.zipController,
                  hintText: 'Enter ZIP code',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: (v) => _required(v, 'ZIP code'),
                ),
                SizedBox(height: 16.h),
                ],
                
                AuthFormField(
                  label: 'Email',
                  controller: _c.emailController,
                  prefixSvgPath: Images.icEmail,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: _email,
                ),
                SizedBox(height: 16.h),
                AuthFormField(
                  label: 'Password',
                  controller: _c.passwordController,
                  prefixSvgPath: Images.icLock,
                  hintText: 'Minimum 8 characters',
                  obscure: true,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: _password,
                ),
                SizedBox(height: 16.h),
                AuthFormField(
                  label: 'Confirm Password',
                  controller: _c.confirmPasswordController,
                  prefixSvgPath: Images.icLock,
                  hintText: 'Re-type Password',
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  borderRadius: 8.r,
                  accentColor: _accent,
                  validator: _confirm,
                ),
                SizedBox(height: 14.h),
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: _c.agreeToTerms.value,
                          onChanged: (_) => _c.toggleTerms(),
                          side: const BorderSide(
                            color: AppColors.authBorder,
                            width: 1.5,
                          ),
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return _accent;
                            }
                            return Colors.white;
                          }),
                          checkColor: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'I agree to the ',
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                height: 1.4,
                                color: AppColors.authTextPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: _c.openTerms,
                              child: Text(
                                'Terms of Service',
                                style: AppFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _accent,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Text(
                              ' and ',
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                height: 1.4,
                                color: AppColors.authTextPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: _c.openPrivacy,
                              child: Text(
                                'Privacy Policy',
                                style: AppFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _accent,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Text(
                              '.',
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                height: 1.4,
                                color: AppColors.authTextPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                Obx(
                  () => PrimaryFilledButton(
                    label: 'Create Account',
                    loading: _c.isLoading.value,
                    onPressed: () => _c.submit(_formKey, _role),
                  ),
                ),
                SizedBox(height: 22.h),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.authTextSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.offNamed(AppRoutes.loginScreen),
                        child: Text(
                          'Login',
                          style: AppFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

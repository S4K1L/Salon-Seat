import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/controller/login_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/auth_form_field.dart';
import 'package:flutter_extension/views/base/facebook_brand_button.dart';
import 'package:flutter_extension/views/base/outlined_icon_label_button.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_extension/views/screen/auth/choose_role/choose_role_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final LoginController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<LoginController>();
  }

  String? _validateEmail(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your email';
    if (!GetUtils.isEmail(s)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 12.h),
                Center(
                  child: Image.asset(
                    Images.logo,
                    width: 72.w,
                    height: 72.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: AppFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.authTextPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Login to your SalonSeat account',
                  textAlign: TextAlign.center,
                  style: AppFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.authTextSecondary,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 22.h),
                AuthFormField(
                  label: 'Email',
                  controller: _c.emailController,
                  prefixSvgPath: Images.icEmail,
                  hintText: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: _validateEmail,
                ),
                SizedBox(height: 14.h),
                AuthFormField(
                  label: 'Password',
                  controller: _c.passwordController,
                  prefixSvgPath: Images.icLock,
                  hintText: 'Enter your password',
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  validator: _validatePassword,
                ),
                SizedBox(height: 12.h),
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: Checkbox(
                          value: _c.rememberMe.value,
                          onChanged: (_) => _c.toggleRememberMe(),
                          side: const BorderSide(
                            color: AppColors.authBorder,
                            width: 1.5,
                          ),
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.authAccent;
                            }
                            return Colors.white;
                          }),
                          checkColor: Colors.white,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Remember me',
                          style: AppFonts.inter(
                            fontSize: 13.sp,
                            color: AppColors.authTextSecondary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _c.onForgotPassword,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot password?',
                          style: AppFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.authAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Obx(
                  () => PrimaryFilledButton(
                    label: 'Login',
                    loading: _c.isLoading.value,
                    onPressed: () => _c.submit(_formKey),
                  ),
                ),
                SizedBox(height: 22.h),
                const _OrDivider(),
                SizedBox(height: 16.h),
                OutlinedIconLabelButton(
                  label: 'Continue with Google',
                  onPressed: _c.onGoogle,
                  leading: SvgPicture.asset(
                    Images.googleG,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
                SizedBox(height: 10.h),
                FacebookBrandButton(
                  label: 'Continue with Facebook',
                  leadingSvgPath: Images.facebookF,
                  onPressed: _c.onFacebook,
                ),
                SizedBox(height: 22.h),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.authTextSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const ChooseRoleScreen()),
                        child: Text(
                          'Sign up',
                          style: AppFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.authAccent,
                          ),
                        ),
                      ),
                    ],
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

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppColors.authBorder,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text(
            'Or continue with',
            style: AppFonts.inter(
              fontSize: 13.sp,
              color: AppColors.authTextSecondary,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppColors.authBorder,
          ),
        ),
      ],
    );
  }
}

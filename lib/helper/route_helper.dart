import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/controller/forgot_password_controller.dart';
import 'package:flutter_extension/controller/listing_plan_controller.dart';
import 'package:flutter_extension/controller/login_controller.dart';
import 'package:flutter_extension/controller/otp_controller.dart';
import 'package:flutter_extension/controller/payment_method_controller.dart';
import 'package:flutter_extension/controller/reset_password_controller.dart';
import 'package:flutter_extension/controller/sign_up_controller.dart';
import 'package:flutter_extension/data/model/reset_password_route_args.dart';
import 'package:flutter_extension/views/screen/auth/forgot_password_screen.dart';
import 'package:flutter_extension/views/screen/auth/login_screen.dart';
import 'package:flutter_extension/views/screen/auth/otp_verification_screen.dart';
import 'package:flutter_extension/views/screen/auth/reset_password_screen.dart';
import 'package:flutter_extension/views/screen/auth/sign_up_screen.dart';
import 'package:flutter_extension/views/screen/choose_role/choose_role_screen.dart';
import 'package:flutter_extension/views/screen/main_nav/main_nav_screen.dart';
import 'package:flutter_extension/views/screen/subscription/listing_plan_screen.dart';
import 'package:flutter_extension/views/screen/subscription/payment_method_screen.dart';
import 'package:get/get.dart';

import '../views/screen/splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String chooseRoleScreen = "/choose_role";
  static String loginScreen = "/login";
  static String signUpScreen = "/sign_up";
  static String otpScreen = "/otp";
  static String forgotPasswordScreen = "/forgot_password";
  static String resetPasswordScreen = "/reset_password";
  static String listingPlanScreen = "/listing_plan";
  static String paymentMethodScreen = "/payment_method";
  static String homeScreen = "/home_screen";

  /// Opens sign-up with [role] in [Get.arguments] (used by [SignUpController]).
  static Future<dynamic>? toSignUp(AppUserRole role) =>
      Get.toNamed(signUpScreen, arguments: role);

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: chooseRoleScreen, page: () => const ChooseRoleScreen()),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<LoginController>()) {
          Get.delete<LoginController>(force: true);
        }
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<SignUpController>()) {
          Get.delete<SignUpController>(force: true);
        }
        Get.put(SignUpController());
      }),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpVerificationScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<OtpController>()) {
          Get.delete<OtpController>(force: true);
        }
        Get.put(OtpController());
      }),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<ForgotPasswordController>()) {
          Get.delete<ForgotPasswordController>(force: true);
        }
        Get.put(ForgotPasswordController());
      }),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() {
        final args = Get.arguments;
        var email = '';
        if (args is ResetPasswordRouteArgs) email = args.email;
        if (Get.isRegistered<ResetPasswordController>()) {
          Get.delete<ResetPasswordController>(force: true);
        }
        Get.put(ResetPasswordController(email: email));
      }),
    ),
    GetPage(
      name: listingPlanScreen,
      page: () => const ListingPlanScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<ListingPlanController>()) {
          Get.delete<ListingPlanController>(force: true);
        }
        Get.put(ListingPlanController());
      }),
    ),
    GetPage(
      name: paymentMethodScreen,
      page: () => const PaymentMethodScreen(),
      binding: BindingsBuilder(() {
        final tier = Get.arguments;
        final idx = tier is int ? tier : 0;
        if (Get.isRegistered<PaymentMethodController>()) {
          Get.delete<PaymentMethodController>(force: true);
        }
        Get.put(PaymentMethodController(planTierIndex: idx));
      }),
    ),
    GetPage(name: homeScreen, page: () => const MainNavScreen()),
  ];
}

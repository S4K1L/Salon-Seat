import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/controller/forgot_password_controller.dart';
import 'package:flutter_extension/controller/listing_plan_controller.dart';
import 'package:flutter_extension/controller/login_controller.dart';
import 'package:flutter_extension/controller/otp_controller.dart';
import 'package:flutter_extension/controller/payment_method_controller.dart';
import 'package:flutter_extension/controller/policy_content_controller.dart';
import 'package:flutter_extension/controller/profile_controller.dart';
import 'package:flutter_extension/controller/reset_password_controller.dart';
import 'package:flutter_extension/controller/sign_up_controller.dart';
import 'package:flutter_extension/controller/tour_request_controller.dart';
import 'package:flutter_extension/controller/business_info_controller.dart';
import 'package:flutter_extension/data/model/policy_page_args.dart';
import 'package:flutter_extension/data/model/reset_password_route_args.dart';
import 'package:flutter_extension/views/screen/auth/forgot_password_screen.dart';
import 'package:flutter_extension/views/screen/auth/login_screen.dart';
import 'package:flutter_extension/views/screen/auth/otp_verification_screen.dart';
import 'package:flutter_extension/views/screen/auth/reset_password_screen.dart';
import 'package:flutter_extension/views/screen/auth/sign_up_screen.dart';
import 'package:flutter_extension/views/screen/auth/beauty_profile_setup_screen.dart';
import 'package:flutter_extension/views/screen/auth/choose_role/choose_role_screen.dart';
import 'package:flutter_extension/views/screen/navbar/owner_navbar.dart';
import 'package:flutter_extension/views/screen/navbar/professional_navbar.dart';
import 'package:flutter_extension/views/screen/common/notifications/notifications_screen.dart';
import 'package:flutter_extension/views/screen/owner/listings/create_listing_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/business_info_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/contact_us_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/content_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/profile_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/tour_request_screen.dart';
import 'package:flutter_extension/views/screen/owner/subscription/listing_plan_screen.dart';
import 'package:flutter_extension/views/screen/owner/subscription/payment_method_screen.dart';
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
  static String beautyProfileSetupScreen = "/beauty_profile_setup";
  static String listingPlanScreen = "/listing_plan";
  static String paymentMethodScreen = "/payment_method";
  static String homeScreen = "/home_screen";
  /// Beauty professional main shell (bottom nav: Home, Listings, Message, Settings).
  static String professionalHomeScreen = "/professional_home";
  static String notificationsScreen = "/notifications";
  static String createListingScreen = "/create_listing";
  static String profileScreen = "/profile_screen";
  static String tourRequestScreen = "/tour_request_screen";
  static String businessInfoScreen = "/business_info_screen";
  static String policyContentScreen = "/policy_content_screen";
  static String contactUsScreen = "/contact_us_screen";

  /// Opens sign-up with [role] in [Get.arguments] (used by [SignUpController]).
  static Future<dynamic>? toSignUp(AppUserRole role) =>
      Get.toNamed(signUpScreen, arguments: role);

  static Future<dynamic>? toPolicyPage(String title) =>
      Get.toNamed(policyContentScreen, arguments: PolicyPageArgs(title: title));

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
      name: beautyProfileSetupScreen,
      page: () => const BeautyProfileSetupScreen(),
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
    GetPage(name: homeScreen, page: () => const OwnerNavScreen()),
    GetPage(
      name: professionalHomeScreen,
      page: () => const ProfessionalNavbar(),
    ),
    GetPage(name: notificationsScreen, page: () => const NotificationsScreen()),
    GetPage(name: createListingScreen, page: () => const CreateListingScreen()),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<ProfileController>()) {
          Get.delete<ProfileController>(force: true);
        }
        Get.put(ProfileController());
      }),
    ),
    GetPage(
      name: tourRequestScreen,
      page: () => const TourRequestScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<TourRequestController>()) {
          Get.delete<TourRequestController>(force: true);
        }
        Get.put(TourRequestController());
      }),
    ),
    GetPage(
      name: businessInfoScreen,
      page: () => const BusinessInfoScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<BusinessInfoController>()) {
          Get.delete<BusinessInfoController>(force: true);
        }
        Get.put(BusinessInfoController());
      }),
    ),
    GetPage(
      name: policyContentScreen,
      page: () {
        final raw = Get.arguments;
        final title = raw is PolicyPageArgs
            ? raw.title
            : raw is String
                ? raw
                : 'Privacy Policy';
        return ContentScreen(title: title);
      },
      binding: BindingsBuilder(() {
        if (Get.isRegistered<PolicyContentController>()) {
          Get.delete<PolicyContentController>(force: true);
        }
        Get.put(PolicyContentController());
      }),
    ),
    GetPage(name: contactUsScreen, page: () => const ContactUsScreen()),
  ];
}

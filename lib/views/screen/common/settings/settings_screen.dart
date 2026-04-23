import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/data/model/policy_page_args.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _items = <_SettingsItem>[
    _SettingsItem(title: 'Profile', icon: Icons.person_outline_rounded),
    _SettingsItem(title: 'Tour Request', icon: Icons.location_on_outlined),
    _SettingsItem(title: 'Business Info', icon: Icons.business_center_outlined),
    _SettingsItem(title: 'Subscription', icon: Icons.inbox_outlined),
    _SettingsItem(
      title: 'Terms & Conditions',
      icon: Icons.info_outline_rounded,
    ),
    _SettingsItem(title: 'Privacy Policy', icon: Icons.shield_outlined),
    _SettingsItem(title: 'About us', icon: Icons.contact_support_outlined),
    _SettingsItem(title: 'Contact Us', icon: Icons.chat_bubble_outline_rounded),
    _SettingsItem(
      title: 'Logout',
      icon: Icons.logout_rounded,
      iconColor: Color(0xFFEF4444),
    ),
  ];

  void _showLogoutDialog() {
    Get.dialog<void>(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Logout?',
                      style: AppFonts.inter(
                        fontSize: 24.sp / 1.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF04444),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: Get.back,
                    borderRadius: BorderRadius.circular(14.r),
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        Icons.close_rounded,
                        size: 22.sp,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'Are you sure you want to logout?',
                style: AppFonts.inter(
                  fontSize: 15.sp / 1.5,
                  color: AppColors.authTextSecondary,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: Get.back,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 42.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6D6D6),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.inter(
                            fontSize: 18.sp / 1.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        Get.offAllNamed(AppRoutes.loginScreen);
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        height: 42.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF04444),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'Logout',
                          style: AppFonts.inter(
                            fontSize: 18.sp / 1.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.45),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
              child: Text(
                'Settings',
                style: AppFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.authTextPrimary,
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFD1D1D1)),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                itemCount: _items.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      if (item.title == 'Profile') {
                        Get.toNamed(AppRoutes.profileScreen);
                      } else if (item.title == 'Tour Request') {
                        Get.toNamed(AppRoutes.tourRequestScreen);
                      } else if (item.title == 'Business Info') {
                        Get.toNamed(AppRoutes.businessInfoScreen);
                      } else if (item.title == 'Subscription') {
                        Get.toNamed(AppRoutes.listingPlanScreen);
                      } else if (item.title == 'Terms & Conditions') {
                        Get.toNamed(
                          AppRoutes.policyContentScreen,
                          arguments: const PolicyPageArgs(
                            title: 'Terms & Conditions',
                          ),
                        );
                      } else if (item.title == 'Privacy Policy') {
                        Get.toNamed(
                          AppRoutes.policyContentScreen,
                          arguments: const PolicyPageArgs(title: 'Privacy Policy'),
                        );
                      } else if (item.title == 'About us') {
                        Get.toNamed(
                          AppRoutes.policyContentScreen,
                          arguments: const PolicyPageArgs(title: 'About us'),
                        );
                      } else if (item.title == 'Contact Us') {
                        Get.toNamed(AppRoutes.contactUsScreen);
                      } else if (item.title == 'Logout') {
                        _showLogoutDialog();
                      }
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE4E4E4)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 22.sp,
                            color: item.iconColor ?? AppColors.authAccent,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            item.title,
                            style: AppFonts.inter(
                              fontSize: 16.sp,
                              color: AppColors.authTextPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem {
  const _SettingsItem({
    required this.title,
    required this.icon,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
}

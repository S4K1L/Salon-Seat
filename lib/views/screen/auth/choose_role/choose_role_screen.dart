import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/choose_role_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/role_option_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  void _goToSignUp(AppUserRole role) {
    Get.find<ChooseRoleController>().setRole(role);
    Get.toNamed(AppRoutes.signUpScreen, arguments: role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.roleScreenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Choose Your Role',
                textAlign: TextAlign.center,
                style: AppFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.roleTitleColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'How do you want to use SalonSeat?',
                textAlign: TextAlign.center,
                style: AppFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.roleSubtitleColor,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 32.h),
              GetBuilder<ChooseRoleController>(
                builder: (controller) => Column(
                  children: [
                    RoleOptionCard(
                      title: 'Salon Owner',
                      description:
                          'List your salon spaces and connect with professionals',
                      isSelected: controller.chosenRole == AppUserRole.salonOwner,
                      leadingSvgPath: Images.iconSalon,
                      onTap: () => _goToSignUp(AppUserRole.salonOwner),
                    ),
                    SizedBox(height: 16.h),
                    RoleOptionCard(
                      title: 'Beauty Professional',
                      description: 'Find and rent perfect salon spaces',
                      isSelected:
                          controller.chosenRole == AppUserRole.beautyProfessional,
                      leadingSvgPath: Images.iconBeautyProfessional,
                      onTap: () => _goToSignUp(AppUserRole.beautyProfessional),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppFonts.inter(
                        fontSize: 14.sp,
                        color: AppColors.roleSubtitleColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.loginScreen),
                      child: Text(
                        'Login',
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.roleAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

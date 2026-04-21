import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/policy_content_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PolicyContentScreen extends StatelessWidget {
  const PolicyContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: GetBuilder<PolicyContentController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.arrow_back),
                        color: AppColors.authTextPrimary,
                        splashRadius: 20.r,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          controller.title,
                          style: AppFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.sections.length,
                      separatorBuilder: (_, __) => SizedBox(height: 18.h),
                      itemBuilder: (context, index) {
                        final section = controller.sections[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section.title,
                              style: AppFonts.inter(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.authTextPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              section.body,
                              style: AppFonts.inter(
                                fontSize: 14.sp,
                                height: 1.45,
                                color: AppColors.authTextSecondary,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

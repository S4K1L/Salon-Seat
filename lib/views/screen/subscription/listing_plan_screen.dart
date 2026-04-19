import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/listing_plan_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListingPlanScreen extends StatelessWidget {
  const ListingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ListingPlanController>();

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
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
                    Text(
                      'Choose your listing plan',
                      style: AppFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text.rich(
                      TextSpan(
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          height: 1.45,
                          color: AppColors.authTextSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Start with a '),
                          TextSpan(
                            text: '7-day free trial',
                            style: AppFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.authTextSecondary,
                            ),
                          ),
                          const TextSpan(
                            text:
                                '. Your subscription begins automatically after the trial.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Obx(
                      () => Column(
                        children: List.generate(
                          ListingPlanController.tiers.length,
                          (i) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _PlanCard(
                              tier: ListingPlanController.tiers[i],
                              selected: c.selectedIndex.value == i,
                              onTap: () => c.select(i),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
              child: PrimaryFilledButton(
                label: 'Continue',
                onPressed: c.continueToPayment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.tier,
    required this.selected,
    required this.onTap,
  });

  final ListingPlanTier tier;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.authAccent;
    final borderColor = selected ? accent : AppColors.authBorder;
    final borderWidth = selected ? 2.0 : 1.0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    tier.priceMain,
                    style: AppFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                  Text(
                    tier.priceSuffix,
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.authTextSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ...tier.bullets.map(
                (line) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: BoxDecoration(
                            color: AppColors.authTextSecondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          line,
                          style: AppFonts.inter(
                            fontSize: 14.sp,
                            height: 1.35,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDashboardHeader extends StatelessWidget {
  const HomeDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: AppFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.authTextPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Welcome back, John!',
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.authAccent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.notifications_none_rounded,
            size: 20.sp,
            color: AppColors.authAccent,
          ),
        ),
      ],
    );
  }
}

class HomeMetricGrid extends StatelessWidget {
  const HomeMetricGrid({super.key, required this.items});

  final List<HomeMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1.15,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 20.h,
      crossAxisSpacing: 20.w,
      children: items
          .map(
            (item) => HomeMetricCard(
              svgAssetPath: item.svgAssetPath,
              iconBg: item.iconBg,
              value: item.value,
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

class HomeMetricItem {
  const HomeMetricItem({
    required this.svgAssetPath,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  final String svgAssetPath;
  final Color iconBg;
  final String value;
  final String label;
}

class HomeMetricCard extends StatelessWidget {
  const HomeMetricCard({
    super.key,
    required this.svgAssetPath,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  final String svgAssetPath;
  final Color iconBg;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              svgAssetPath,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: AppFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.authTextPrimary,
            ),
          ),
          Text(
            label,
            style: AppFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.authTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCurrentPlanCard extends StatelessWidget {
  const HomeCurrentPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Current Plan',
                style: AppFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.authTextPrimary,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: const Color(0xFFD8F5E9),
                ),
                child: Text(
                  'Active',
                  style: AppFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF2DBA83),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Listings',
                style: AppFonts.inter(
                  fontSize: 12.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                'Tier 2',
                style: AppFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5A60FF),
                ),
              ),
              const Spacer(),
              Text(
                '4 of 10',
                style: AppFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.authTextPrimary,
                ),
              ),
            ],
          ),
          Text(
            '\$14.99/month',
            style: AppFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.authTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeRecentListingsHeader extends StatelessWidget {
  const HomeRecentListingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Recent Listings',
          style: AppFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
        const Spacer(),
        Text(
          'View All',
          style: AppFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF5865FF),
          ),
        ),
      ],
    );
  }
}

class HomeRecentListingCard extends StatelessWidget {
  const HomeRecentListingCard({
    super.key,
    required this.imageEmoji,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.active,
  });

  final String imageEmoji;
  final String title;
  final String location;
  final String price;
  final String status;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final statusBg = active ? const Color(0xFFD8F5E9) : const Color(0xFFFFF3D6);
    final statusText = active ? const Color(0xFF2DBA83) : const Color(0xFFFFB000);
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF92D9E0), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE9DED0), Color(0xFFC8B198)],
              ),
            ),
            alignment: Alignment.center,
            child: Text(imageEmoji, style: TextStyle(fontSize: 24.sp)),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        status,
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: statusText,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  location,
                  style: AppFonts.inter(
                    fontSize: 16.sp,
                    color: AppColors.authTextSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  price,
                  style: AppFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5865FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

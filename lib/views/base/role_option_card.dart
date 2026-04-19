import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleOptionCard extends StatelessWidget {
  const RoleOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.leadingSvgPath,
    required this.onTap,
  });

  final String title;
  final String description;
  final bool isSelected;
  /// Asset path to an SVG (e.g. [Images.iconSalon]).
  final String leadingSvgPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = 14.r;
    final iconBoxSize = 48.w;
    final iconColor =
        isSelected ? AppColors.roleCardSelected : AppColors.roleIconMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.roleCardSelected : Colors.white,
            borderRadius: BorderRadius.circular(radius),
            border: isSelected
                ? null
                : Border.all(color: AppColors.roleCardBorder),
            boxShadow: isSelected
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            child: Row(
              children: [
                Container(
                  width: iconBoxSize,
                  height: iconBoxSize,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? Colors.white : AppColors.roleIconBoxMuted,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.w),
                  child: SvgPicture.asset(
                    leadingSvgPath,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.inter(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : AppColors.roleTitleColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: AppFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.35,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.95)
                              : AppColors.roleSubtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 22.sp,
                  color: isSelected ? Colors.white : AppColors.roleArrowMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

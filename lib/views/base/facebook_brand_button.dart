import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Facebook brand-style solid button (blue background, white label).
class FacebookBrandButton extends StatelessWidget {
  const FacebookBrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingSvgPath,
    this.enabled = true,
    this.height,
    this.borderRadius,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? leadingSvgPath;
  final bool enabled;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 10.r;

    return SizedBox(
      width: double.infinity,
      height: height ?? 46.h,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.authFacebookBlue,
          disabledBackgroundColor:
              AppColors.authFacebookBlue.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingSvgPath != null) ...[
              SvgPicture.asset(
                leadingSvgPath!,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8.w),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

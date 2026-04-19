import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Outlined pill button with a leading widget (e.g. SVG) — Google sign-in, secondary actions.
class OutlinedIconLabelButton extends StatelessWidget {
  const OutlinedIconLabelButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.leading,
    this.enabled = true,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget leading;
  final bool enabled;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 10.r;
    final fg = foregroundColor ?? AppColors.authTextPrimary;
    final border = borderColor ?? AppColors.authBorder;

    return SizedBox(
      width: double.infinity,
      height: height ?? 46.h,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: fg,
          side: BorderSide(color: border, width: 1),
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
            leading,
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: enabled ? fg : fg.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

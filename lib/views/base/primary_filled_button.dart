import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Wide rounded CTA: vertical teal gradient, flat (no shadow), Inter label — matches login primary.
class PrimaryFilledButton extends StatelessWidget {
  const PrimaryFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.gradientStart,
    this.gradientEnd,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool enabled;
  final double? width;
  final double? height;
  /// Rounded rect radius (~12–15). Defaults to [14].
  final double? borderRadius;
  /// If set, uses solid fill instead of gradient.
  final Color? backgroundColor;
  /// Gradient top color (brighter teal).
  final Color? gradientStart;
  /// Gradient bottom color (deeper teal).
  final Color? gradientEnd;

  @override
  Widget build(BuildContext context) {
    final h = height ?? 45.h;
    final effectiveOnPressed = (loading || !enabled) ? null : onPressed;
    final r = borderRadius ?? 14.r;

    final useSolid = backgroundColor != null;
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        gradientStart ?? AppColors.primaryGradientStart,
        gradientEnd ?? AppColors.primaryGradientEnd,
      ],
    );

    final child = loading
        ? SizedBox(
            width: 20.w,
            height: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Text(
            label,
            textAlign: TextAlign.center,
            style: AppFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          );

    return SizedBox(
      width: width ?? double.infinity,
      height: h,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: effectiveOnPressed,
          borderRadius: BorderRadius.circular(r),
          splashColor: Colors.white.withValues(alpha: 0.18),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(r),
              color: useSolid ? backgroundColor : null,
              gradient: useSolid ? null : gradient,
            ),
            child: Opacity(
              opacity: enabled ? 1 : 0.55,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

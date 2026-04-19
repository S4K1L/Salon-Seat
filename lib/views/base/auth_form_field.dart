import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Light-theme labeled field. [prefixSvgPath] optional — omit for plain text fields.
class AuthFormField extends StatefulWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixSvgPath,
    this.hintText,
    this.supportingText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscure = false,
    this.autofillHints,
    this.borderRadius,
    this.accentColor,
  });

  final String label;
  final TextEditingController controller;
  final String? prefixSvgPath;
  final String? hintText;
  final String? supportingText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscure;
  final Iterable<String>? autofillHints;
  /// Corner radius for the input box (default ~10).
  final double? borderRadius;
  /// Focus border & cursor (defaults to [AppColors.authAccent]).
  final Color? accentColor;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  bool _obscure = true;

  OutlineInputBorder _border(Color color, {double width = 1}) {
    final r = widget.borderRadius ?? 10.r;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(r),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? AppColors.authAccent;
    final hasPrefix = widget.prefixSvgPath != null;

    final prefix = hasPrefix
        ? Padding(
            padding: EdgeInsets.only(left: 12.w, right: 4.w),
            child: SvgPicture.asset(
              widget.prefixSvgPath!,
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.authTextPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure ? _obscure : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autofillHints: widget.autofillHints,
          style: AppFonts.inter(
            fontSize: 15.sp,
            height: 1.25,
            color: AppColors.authTextPrimary,
          ),
          cursorColor: accent,
          validator: widget.validator,
          decoration: InputDecoration(
            errorStyle: AppFonts.inter(
              fontSize: 11.sp,
              height: 1.2,
              color: AppColors.authBorderError,
            ),
            isDense: true,
            filled: true,
            fillColor: AppColors.authFieldFill,
            hintText: widget.hintText,
            hintStyle: AppFonts.inter(
              fontSize: 15.sp,
              height: 1.25,
              color: AppColors.authHint,
            ),
            contentPadding: EdgeInsetsDirectional.only(
              start: hasPrefix ? 4.w : 14.w,
              end: 8.w,
              top: 11.h,
              bottom: 11.h,
            ),
            prefixIcon: prefix,
            prefixIconConstraints: hasPrefix
                ? BoxConstraints(
                    minWidth: 38.w,
                    maxHeight: 40.h,
                  )
                : null,
            suffixIcon: widget.obscure
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 40.w,
                      minHeight: 40.h,
                      maxHeight: 40.h,
                    ),
                    splashRadius: 18.r,
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: SvgPicture.asset(
                      _obscure ? Images.icEyeOff : Images.icEye,
                      width: 18.w,
                      height: 18.w,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
            border: _border(AppColors.authBorder),
            enabledBorder: _border(AppColors.authBorder),
            focusedBorder: _border(accent, width: 1.5),
            errorBorder: _border(AppColors.authBorderError, width: 1.5),
            focusedErrorBorder:
                _border(AppColors.authBorderError, width: 1.5),
          ),
        ),
        if (widget.supportingText != null) ...[
          SizedBox(height: 6.h),
          Text(
            widget.supportingText!,
            style: AppFonts.inter(
              fontSize: 12.sp,
              color: AppColors.authTextSecondary,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }
}

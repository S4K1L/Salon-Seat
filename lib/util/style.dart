import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_fonts.dart';

class AppStyles {
  static TextStyle h1(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return AppFonts.inter(
        color: color,
        fontSize: 24.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h2(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return AppFonts.inter(
        color: color,
        fontSize: 20.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h3({
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return AppFonts.inter(
        color: color,
        fontSize: 18.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h4(
      {Color? color,
      FontWeight? fontWeight,
      double? letterSpacing,
      double? height}) {
    return AppFonts.inter(
        fontSize: 16.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h5(
      {Color? color,
      FontWeight? fontWeight,
      double? letterSpacing,
      double? height}) {
    return AppFonts.inter(
        fontSize: 14.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle h6(
      {Color? color,
      FontWeight? fontWeight,
      double? letterSpacing,
      double? height}) {
    return AppFonts.inter(
        fontSize: 12.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle customSize(
      {Color? color,
      required double size,
      String? family,
      double? letterSpacing,
      double? height,
      FontWeight? fontWeight}) {
    if (family != null) {
      return TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
        fontSize: size,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family,
      );
    }
    return AppFonts.inter(
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      fontSize: size,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static BoxShadow boxShadow = BoxShadow(
      blurRadius: 4,
      offset: const Offset(0, 0),
      color: Colors.black.withValues(alpha: 0.02),
      spreadRadius: 0);
}

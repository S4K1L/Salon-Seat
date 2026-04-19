import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Inter is the default typeface for the app. Use [inter] or theme [TextTheme].
abstract final class AppFonts {
  static TextStyle inter({
    required double fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}

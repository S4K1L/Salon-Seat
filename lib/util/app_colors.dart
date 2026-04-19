import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF13ADBB,
    <int, Color>{
      50: Color(0xFFE7F1F8),
      100: Color(0xFFB6E6EA),
      200: Color(0xFF92D9E0),
      300: Color(0xFF61C8D1),
      400: Color(0xFF42BDC9),
      500: Color(0xFF13ADBB),
      600: Color(0xFF119DAA),
      700: Color(0xFF0D7B85),
      800: Color(0xFF0A5F67),
      900: Color(0xFF08494F),
    },
  );

  static const Color primaryColor = Color(0xFF13ADBB);
  static const Color primaryLight = Color(0xFF42BDC9);
  static const Color primaryDark = Color(0xFF0D7B85);

  static const Color backgroundColor = Color(0xFF010101);

  /// Splash screen (matches brand mockup)
  static const Color splashBackground = Color(0xFF121212);
  static const Color splashAccent = Color(0xFF20A4B4);

  /// Choose Your Role (light screen)
  static const Color roleScreenBackground = Color(0xFFF5F5F5);
  static const Color roleCardSelected = Color(0xFF17AAB5);
  static const Color roleCardBorder = Color(0xFFE0E0E0);
  static const Color roleTitleColor = Color(0xFF111111);
  static const Color roleSubtitleColor = Color(0xFF757575);
  static const Color roleAccent = Color(0xFF17AAB5);
  static const Color roleIconBoxMuted = Color(0xFFE3F2F4);
  static const Color roleIconMuted = Color(0xFF9E9E9E);
  static const Color roleArrowMuted = Color(0xFFBDBDBD);

  /// Auth / login (light)
  static const Color authBackground = Color(0xFFF5F5F5);
  static const Color authFieldFill = Color(0xFFF0F0F0);
  static const Color authBorder = Color(0xFFE0E0E0);
  static const Color authBorderError = Color(0xFFE53935);
  static const Color authTextPrimary = Color(0xFF333333);
  static const Color authTextSecondary = Color(0xFF666666);
  static const Color authHint = Color(0xFF999999);
  static const Color authAccent = Color(0xFF17AAB5);
  /// Sign-up CTA / role highlight (solid teal)
  static const Color signUpPrimary = Color(0xFF12A5B5);

  static const Color otpBackground = Color(0xFFF8F8F8);

  /// Primary CTA vertical gradient (top → bottom), e.g. [PrimaryFilledButton]
  static const Color primaryGradientStart = Color(0xFF13B9CE);
  static const Color primaryGradientEnd = Color(0xFF0C97A7);
  static const Color authFacebookBlue = Color(0xFF1877F2);

  static const Color cardColor = Color(0xFF2F2F2F);
  static const Color cardLightColor = Color(0xFF555555);

  static const Color borderColor = primaryColor;
  static const Color dividerColor = Color(0xFF555555);

  static const Color textColor = Color(0xFFFFFFFF);
  static const Color subTextColor = Color(0xFFE8E8E8);
  static const Color hintColor = Color(0xFFB5B5B5);
  static const Color greyColor = Color(0xFFB5B5B5);

  static Color fillColor = const Color(0xFF13ADBB).withValues(alpha: 0.1);
  static const Color shadowColor = Color(0xFF2B2A2A);

  static const Color bottomBarColor = Color(0xFF343434);

  static const BoxShadow shadow = BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: shadowColor,
    offset: Offset(0, 2),
  );
}
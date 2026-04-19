/// Passed as [Get.arguments] when opening the OTP screen.
class OtpRouteArgs {
  const OtpRouteArgs({
    required this.email,
    this.purpose = OtpPurpose.signUp,
    this.afterVerification,
  });

  final String email;
  final OtpPurpose purpose;

  /// When null, [resolvedAfterVerification] derives a default from [purpose].
  final OtpAfterVerification? afterVerification;

  OtpAfterVerification get resolvedAfterVerification {
    if (afterVerification != null) return afterVerification!;
    switch (purpose) {
      case OtpPurpose.signUp:
        return OtpAfterVerification.listingPlan;
      case OtpPurpose.forgotPassword:
        return OtpAfterVerification.resetPassword;
    }
  }
}

enum OtpPurpose { signUp, forgotPassword }

/// Where to navigate after the user successfully confirms the OTP.
enum OtpAfterVerification {
  login,
  home,
  resetPassword,
  /// Sign-up completion: choose subscription tier, then payment.
  listingPlan,
}

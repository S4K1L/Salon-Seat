import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/payment_method_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PaymentMethodController>();

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 4.h, right: 8.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18.sp,
                          color: AppColors.authTextSecondary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Back',
                          style: AppFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.authTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Select the payment method you want to use',
                      style: AppFonts.inter(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.authTextPrimary,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => Column(
                        children: [
                          _PaymentOptionTile(
                            label: 'Cards',
                            leading: const _PaymentBrandSvg(
                              asset: Images.icMasterCard,
                            ),
                            selected:
                                c.selectedMethod.value == AppPaymentMethod.cards,
                            onTap: () => c.select(AppPaymentMethod.cards),
                          ),
                          SizedBox(height: 12.h),
                          _PaymentOptionTile(
                            label: 'Stripe',
                            leading: const _PaymentBrandSvg(
                              asset: Images.icStripe,
                            ),
                            selected: c.selectedMethod.value ==
                                AppPaymentMethod.stripe,
                            onTap: () => c.select(AppPaymentMethod.stripe),
                          ),
                          SizedBox(height: 12.h),
                          _PaymentOptionTile(
                            label: 'Paypal',
                            leading: const _PaymentBrandSvg(
                              asset: Images.icPaypal,
                            ),
                            selected: c.selectedMethod.value ==
                                AppPaymentMethod.paypal,
                            onTap: () => c.select(AppPaymentMethod.paypal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
              child: Obx(
                () => PrimaryFilledButton(
                  label: 'Make Payment',
                  loading: c.isLoading.value,
                  onPressed: c.makePayment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  const _PaymentOptionTile({
    required this.label,
    required this.leading,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.authAccent;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? accent : AppColors.authBorder,
              width: selected ? 2 : 1,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              leading,
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  label,
                  style: AppFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.authTextPrimary,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? accent : AppColors.authTextSecondary,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentBrandSvg extends StatelessWidget {
  const _PaymentBrandSvg({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.w,
      height: 35.h,
      child: SvgPicture.asset(
        asset,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

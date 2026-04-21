import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/business_info_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BusinessInfoScreen extends StatelessWidget {
  const BusinessInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: GetBuilder<BusinessInfoController>(
          builder: (controller) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: Get.back,
                              icon: const Icon(Icons.arrow_back),
                              color: AppColors.authTextPrimary,
                              splashRadius: 20.r,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Business Information',
                              style: AppFonts.inter(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.authTextPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        const _Label(text: 'Business Name'),
                        SizedBox(height: 8.h),
                        _InputField(
                          controller: controller.businessNameController,
                          hint: 'Business Name',
                        ),
                        SizedBox(height: 14.h),
                        const _Label(text: 'Business Address'),
                        SizedBox(height: 8.h),
                        _InputField(
                          controller: controller.businessAddressController,
                          hint: '123 Main Street',
                        ),
                        SizedBox(height: 14.h),
                        const _Label(text: 'City'),
                        SizedBox(height: 8.h),
                        _InputField(
                          controller: controller.cityController,
                          hint: 'Dallas',
                        ),
                        SizedBox(height: 14.h),
                        const _Label(text: 'ZIP Code'),
                        SizedBox(height: 8.h),
                        _InputField(
                          controller: controller.zipCodeController,
                          hint: '75201',
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                  child: PrimaryFilledButton(
                    label: 'Save Changes',
                    height: 50.h,
                    borderRadius: 10.r,
                    onPressed: controller.saveChanges,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.authTextPrimary,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppFonts.inter(fontSize: 16.sp, color: AppColors.authTextPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xFF9C9C9C),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFB5B5B5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.authAccent, width: 1.2),
        ),
      ),
    );
  }
}

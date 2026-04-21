import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_extension/controller/profile_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<ProfileController>(
                      builder: (controller) => _ProfileHeader(
                        selectedImagePath: controller.selectedImagePath,
                        onEditTap: controller.pickProfileImage,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    const _FieldLabel(text: 'Full Name'),
                    SizedBox(height: 10.h),
                    const _ProfileInputField(hintText: 'Esther Howard'),
                    SizedBox(height: 20.h),
                    const _FieldLabel(text: 'Email Address'),
                    SizedBox(height: 10.h),
                    const _ProfileInputField(
                      hintText: 'name@example.com',
                      isReadOnly: true,
                      suffixIcon: Icons.lock_outline_rounded,
                    ),
                    SizedBox(height: 20.h),
                    const _FieldLabel(text: 'Phone Number'),
                    SizedBox(height: 10.h),
                    const _ProfileInputField(hintText: '0123654789'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 20.h),
              child: PrimaryFilledButton(
                label: 'Save Changes',
                height: 54.h,
                borderRadius: 12.r,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.selectedImagePath,
    required this.onEditTap,
  });

  final String? selectedImagePath;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatarImage = selectedImagePath == null
        ? AssetImage(Images.placeholder)
        : FileImage(File(selectedImagePath!));

    return Column(
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
              'Profile',
              style: AppFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextPrimary,
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () => Get.toNamed(AppRoutes.tourRequestScreen),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 22.sp,
                  color: AppColors.authAccent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 106.w,
              height: 106.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.authAccent, width: 2.w),
                image: DecorationImage(image: avatarImage, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: -6.h,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onEditTap,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: AppColors.authAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

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

class _ProfileInputField extends StatelessWidget {
  const _ProfileInputField({
    required this.hintText,
    this.isReadOnly = false,
    this.suffixIcon,
  });

  final String hintText;
  final bool isReadOnly;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      style: AppFonts.inter(fontSize: 16.sp, color: AppColors.authTextPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.inter(
          fontSize: 16.sp,
          color: const Color(0xFF6F6F6F),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFFBFBFBF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.authAccent, width: 1.2),
        ),
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: Icon(
                  suffixIcon,
                  size: 20.sp,
                  color: const Color(0xFF757575),
                ),
              ),
        suffixIconConstraints: BoxConstraints(minWidth: 28.w, minHeight: 20.h),
      ),
    );
  }
}

class _ProfileLinkTile extends StatelessWidget {
  const _ProfileLinkTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFDBDBDB)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.authTextPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColors.authTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

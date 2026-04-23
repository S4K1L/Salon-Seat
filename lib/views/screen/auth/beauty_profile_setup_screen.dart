import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BeautyProfileSetupScreen extends StatefulWidget {
  const BeautyProfileSetupScreen({super.key});

  @override
  State<BeautyProfileSetupScreen> createState() => _BeautyProfileSetupScreenState();
}

class _BeautyProfileSetupScreenState extends State<BeautyProfileSetupScreen> {
  final TextEditingController _fullNameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+8801616268000',
  );
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedProfession;

  static const List<String> _professions = <String>[
    'Hair Stylist',
    'Barber',
    'Nail Technician',
    'Makeup Artist',
    'Esthetician',
    'Lash Technician',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _showWelcomeDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Image.asset(Images.icVerifiedEmail, width: 200.w, height: 200.w),
              ),
              SizedBox(height: 14.h),
              Text(
                'Welcome To SalonSeat',
                style: AppFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.authTextPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Your profile is ready. Start exploring salon spaces in your city',
                textAlign: TextAlign.center,
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.authTextSecondary,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 18.h),
              PrimaryFilledButton(label: 'Browse Listings', onPressed: () {
                Navigator.of(dialogContext).pop();
                Get.offAllNamed(AppRoutes.professionalHomeScreen);
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: AppColors.authTextSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Back',
                        style: AppFonts.inter(
                          fontSize: 16.sp,
                          color: AppColors.authTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Setup your profile',
                  style: AppFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.authTextPrimary,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 44.r,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
                      ),
                      backgroundColor: const Color(0xFFD8E0E5),
                    ),
                    Positioned(
                      right: -2.w,
                      bottom: -2.h,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF18B3C1),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.edit, size: 14.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _buildFieldLabel('Full Name'),
              _buildTextField(controller: _fullNameController, hint: 'John Doe'),
              SizedBox(height: 10.h),
              _buildFieldLabel('Phone Number'),
              _buildTextField(
                controller: _phoneController,
                hint: '+8801616268000',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10.h),
              _buildFieldLabel('What type of beauty professional are you?'),
              DropdownButtonFormField<String>(
                value: _selectedProfession,
                items: _professions
                    .map(
                      (profession) => DropdownMenuItem<String>(
                        value: profession,
                        child: Text(
                          profession,
                          style: AppFonts.inter(
                            fontSize: 15.sp,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedProfession = value),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22.sp,
                  color: AppColors.authTextSecondary,
                ),
                hint: Text(
                  'Select one',
                  style: AppFonts.inter(
                    fontSize: 15.sp,
                    color: const Color(0xFF8C8C8C),
                  ),
                ),
                decoration: _inputDecoration(),
              ),
              SizedBox(height: 10.h),
              _buildFieldLabel('Years of Experience'),
              _buildTextField(
                controller: _experienceController,
                hint: 'How many years have you worked?',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.h),
              _buildFieldLabel('Where are you looking for a salon space?'),
              _buildTextField(
                controller: _addressController,
                hint: 'Street address, city, state, ZIP code',
              ),
              SizedBox(height: 18.h),

              PrimaryFilledButton(label: 'Finish Setup', onPressed: _showWelcomeDialog),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: AppFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.authTextPrimary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppFonts.inter(
        fontSize: 15.sp,
        color: AppColors.authTextPrimary,
      ),
      decoration: _inputDecoration().copyWith(
        hintText: hint,
        hintStyle: AppFonts.inter(
          fontSize: 15.sp,
          color: const Color(0xFF9E9E9E),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFFDADADA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFF18B2C2)),
      ),
    );
  }
}

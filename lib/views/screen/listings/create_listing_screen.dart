import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/create_listing_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateListingScreen extends StatelessWidget {
  const CreateListingScreen({super.key});

  Widget _textField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.authTextPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppFonts.inter(
                fontSize: 16.sp,
                color: const Color(0xFFA0A0A0),
              ),
              filled: true,
              fillColor: AppColors.authBackground,
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFAEAEAE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFAEAEAE)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.authTextPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          DropdownButtonFormField<String>(
            initialValue: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFFA0A0A0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFAEAEAE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Color(0xFFAEAEAE)),
              ),
            ),
            items: items.map((v) => DropdownMenuItem<String>(value: v, child: Text(v))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _stepContent(BuildContext context, CreateListingController controller) {
    switch (controller.step) {
      case 0:
        return Column(
          children: [
            _textField('Business Name', 'Your Salon Name'),
            _textField('Listing Title', '123 Main St, Los Angeles, CA'),
            _textField('Street Address', '123 Main St, Los Angeles, CA'),
            _textField('City', 'Los Angeles, CA'),
            _textField('Zip / Postal Code', 'e.g., 90210 or SW1A 1AA'),
            _textField('Country', 'e.g., United States'),
            _textField('Map Coordinates', 'Paste Google Maps link'),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amenities',
              style: AppFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              children: CreateListingController.amenities.map((item) {
                final selected = controller.selectedAmenities.contains(item);
                return SizedBox(
                  width: 160.w,
                  child: InkWell(
                    onTap: () => controller.toggleAmenity(item),
                    child: Row(
                      children: [
                        Container(
                          width: 22.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: const Color(0xFF9F9F9F), width: 1.6),
                          ),
                          alignment: Alignment.center,
                          child: selected
                              ? Icon(
                                  Icons.check_rounded,
                                  size: 16.sp,
                                  color: const Color(0xFF19A7B5),
                                )
                              : null,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item,
                            style: AppFonts.inter(fontSize: 16.sp, color: AppColors.authTextPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12.h),
            _textField('Description', 'Describe your salon space...', maxLines: 4),
          ],
        );
      case 2:
        return Column(
          children: [
            _dropdownField(
              label: 'Rental Type',
              hint: 'Select type',
              value: controller.rentalType,
              items: const ['Chair Rental', 'Salon Station', 'Private Suite', 'Booth Space'],
              onChanged: controller.setRentalType,
            ),
            _dropdownField(
              label: 'Lease Terms',
              hint: 'Select terms',
              value: controller.leaseTerms,
              items: const ['Monthly', 'Weekly', 'Daily'],
              onChanged: controller.setLeaseTerms,
            ),
            _textField('Price / Rent Amount', '500'),
            _dropdownField(
              label: 'Availability Status',
              hint: 'Select status',
              value: controller.availabilityStatus,
              items: const ['Active', 'Paused', 'Draft'],
              onChanged: controller.setAvailabilityStatus,
            ),
            _textField('Maximum Occupancy', '10'),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => controller.pickFiles(),
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFF2F82FF)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 36.sp, color: const Color(0xFF2F82FF)),
                    SizedBox(height: 8.h),
                    Text.rich(
                      TextSpan(
                        text: 'Drag photos or ',
                        style: AppFonts.inter(fontSize: 12.sp, color: AppColors.authTextPrimary),
                        children: [
                          TextSpan(
                            text: 'browse',
                            style: AppFonts.inter(fontSize: 12.sp, color: const Color(0xFF2F82FF)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Max 50 MB files are allowed',
                      style: AppFonts.inter(fontSize: 12.sp, color: const Color(0xFF9A9A9A)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Only support PNG and PDF format',
              style: AppFonts.inter(fontSize: 13.sp, color: AppColors.authTextSecondary),
            ),
            SizedBox(height: 10.h),
            ...List.generate(
              controller.uploadedFiles.length,
              (index) => _UploadItem(
                name: controller.uploadedFiles[index].name,
                size: controller.uploadedFiles[index].sizeLabel,
                onChange: () => controller.pickFiles(replace: true, replaceAtIndex: index),
                onDelete: () => controller.removeFileAt(index),
              ),
            ),
            if (controller.uploadedFiles.isEmpty)
              Text(
                'No files uploaded yet.',
                style: AppFonts.inter(fontSize: 12.sp, color: const Color(0xFF9A9A9A)),
              ),
          ],
        );
      default:
        return Column(
          children: [
            _textField('Rules / Restrictions', 'Write your rules & restrictions', maxLines: 4),
            _textField('Additional Notes', 'Write Additional Notes'),
            SizedBox(height: 8.h),
            PrimaryFilledButton(label: 'Save', onPressed: () => Get.back(), enabled: true),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateListingController>(
      init: CreateListingController(),
      global: false,
      builder: (controller) {
        final stepLabel = 'Step ${controller.step + 1} of 5: ${CreateListingController.stepTitles[controller.step]}';
        return Scaffold(
          backgroundColor: AppColors.authBackground,
          appBar: AppBar(
            backgroundColor: AppColors.authBackground,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (controller.step == 0) {
                  Get.back();
                } else {
                  controller.previousStep();
                }
              },
            ),
            title: Text(
              'Create Listing',
              style: AppFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextPrimary,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: index == 4 ? 0 : 8.w),
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: index <= controller.step ? const Color(0xFF19A7B5) : const Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        stepLabel,
                        style: AppFonts.inter(fontSize: 16.sp, color: AppColors.authTextSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFD0D0D0)),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
                  child: _stepContent(context, controller),
                ),
              ),
              if (controller.step < 4)
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryFilledButton(
                          label: 'Save Draft',
                          onPressed: () {},
                          backgroundColor: const Color(0xFFE0E0E0),
                          textColor: AppColors.authTextPrimary,
                          enabled: true,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: PrimaryFilledButton(
                          label: 'Next',
                          onPressed: controller.nextStep,
                          enabled: true,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _UploadItem extends StatelessWidget {
  const _UploadItem({
    required this.name,
    required this.size,
    required this.onChange,
    required this.onDelete,
  });

  final String name;
  final String size;
  final VoidCallback onChange;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: const Color(0xFFE9E9E9),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.insert_drive_file_outlined, size: 20.sp, color: const Color(0xFF666666)),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppFonts.inter(fontSize: 12.sp, color: AppColors.authTextPrimary)),
                Text(size, style: AppFonts.inter(fontSize: 12.sp, color: const Color(0xFF9A9A9A))),
              ],
            ),
          ),
          GestureDetector(
            onTap: onChange,
            child: Text(
              'Change',
              style: AppFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF2F82FF),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete_outline, size: 16.sp, color: const Color(0xFFFF5A40)),
          ),
        ],
      ),
    );
  }
}

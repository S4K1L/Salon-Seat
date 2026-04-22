import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/listing_item_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListingDetailScreen extends StatefulWidget {
  const ListingDetailScreen({
    super.key,
    required this.item,
    required this.isEditMode,
    this.onSave,
  });

  final ListingItem item;
  final bool isEditMode;
  final ValueChanged<ListingItem>? onSave;

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _locationController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title.replaceAll('\n', ' '));
    _locationController = TextEditingController(text: widget.item.location);
    _priceController = TextEditingController(text: widget.item.price);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.isEditMode;
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        backgroundColor: AppColors.authBackground,
        elevation: 0,
        title: Text(
          isEditMode ? 'Edit Listing' : 'Listing Details',
          style: AppFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  widget.item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE8E8E8),
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            _DetailsField(
              label: 'Title',
              controller: _titleController,
              readOnly: !isEditMode,
            ),
            SizedBox(height: 12.h),
            _DetailsField(
              label: 'Location',
              controller: _locationController,
              readOnly: !isEditMode,
            ),
            SizedBox(height: 12.h),
            _DetailsField(
              label: 'Price',
              controller: _priceController,
              readOnly: !isEditMode,
            ),
            SizedBox(height: 12.h),
            Text(
              'Status',
              style: AppFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            _StatusBadge(status: widget.item.status),
            if (isEditMode) ...[
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () {
                    final updated = widget.item.copyWith(
                      title: _titleController.text.trim(),
                      location: _locationController.text.trim(),
                      price: _priceController.text.trim(),
                    );
                    widget.onSave?.call(updated);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF19A7B5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: AppFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailsField extends StatelessWidget {
  const _DetailsField({
    required this.label,
    required this.controller,
    required this.readOnly,
  });

  final String label;
  final TextEditingController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.authTextSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          readOnly: readOnly,
          style: AppFonts.inter(
            fontSize: 16.sp,
            color: AppColors.authTextPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: readOnly ? const Color(0xFFF5F5F5) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF19A7B5)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final ListingStatus status;

  @override
  Widget build(BuildContext context) {
    final ({String label, Color bg, Color text}) style = switch (status) {
      ListingStatus.active => (
          label: 'Active',
          bg: const Color(0xFFBDEED9),
          text: const Color(0xFF0CAE74)
        ),
      ListingStatus.paused => (
          label: 'Paused',
          bg: const Color(0xFFF7E4AE),
          text: const Color(0xFFF09D00)
        ),
      ListingStatus.draft => (
          label: 'Draft',
          bg: const Color(0xFFEAEAEA),
          text: const Color(0xFF777777)
        ),
      ListingStatus.pending => (
          label: 'Pending',
          bg: const Color(0xFFE7ECFF),
          text: const Color(0xFF4A63C7)
        ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        style.label,
        style: AppFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: style.text,
        ),
      ),
    );
  }
}

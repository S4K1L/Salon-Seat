import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/listing_item_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListingsFilterChip extends StatelessWidget {
  const ListingsFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF19A7B5) : const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : AppColors.authTextSecondary,
          ),
        ),
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  const ListingCard({
    super.key,
    required this.item,
    required this.onViewTap,
    required this.onEditTap,
    required this.onPauseTap,
    required this.onDeleteTap,
  });

  final ListingItem item;
  final VoidCallback onViewTap;
  final VoidCallback onEditTap;
  final VoidCallback onPauseTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    final badge = _statusStyle(item.status);
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.authBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFDADADA), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 118.w,
              height: 118.h,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFE8E8E8),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.authTextPrimary,
                          height: 1.35,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: badge.background,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        badge.label,
                        style: AppFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: badge.text,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item.location,
                  style: AppFonts.inter(
                    fontSize: 16.sp,
                    color: const Color(0xFF9A9A9A),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  item.price,
                  style: AppFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0699A9),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    _ActionPill(
                      label: 'View',
                      bg: Color(0xFFD6ECFA),
                      textColor: Color(0xFF0E8FB3),
                      onTap: onViewTap,
                    ),
                    SizedBox(width: 14.w),
                    _ActionText(label: 'Edit', onTap: onEditTap),
                    SizedBox(width: 14.w),
                    _ActionText(label: 'Pause', onTap: onPauseTap),
                    const Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onDeleteTap,
                        borderRadius: BorderRadius.circular(12.r),
                        child: Ink(
                          width: 44.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7DFE1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 24.sp,
                              color: const Color(0xFFFA1B26),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

({String label, Color background, Color text}) _statusStyle(ListingStatus status) {
  switch (status) {
    case ListingStatus.active:
      return (
        label: 'Active',
        background: const Color(0xFFBDEED9),
        text: const Color(0xFF0CAE74),
      );
    case ListingStatus.paused:
      return (
        label: 'Paused',
        background: const Color(0xFFF7E4AE),
        text: const Color(0xFFF09D00),
      );
    case ListingStatus.draft:
      return (
        label: 'Draft',
        background: const Color(0xFFEAEAEA),
        text: const Color(0xFF777777),
      );
    case ListingStatus.pending:
      return (
        label: 'Pending',
        background: const Color(0xFFE7ECFF),
        text: const Color(0xFF4A63C7),
      );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.label,
    required this.bg,
    required this.textColor,
    this.onTap,
  });

  final String label;
  final Color bg;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999.r)),
        child: Text(
          label,
          style: AppFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _ActionText extends StatelessWidget {
  const _ActionText({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppFonts.inter(fontSize: 13.sp, color: const Color(0xFF666666)),
      ),
    );
  }
}

class ListingsEmptyStateCard extends StatelessWidget {
  const ListingsEmptyStateCard({super.key, required this.onCreateTap});

  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.authBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE3E3E3)),
      ),
      child: Column(
        children: [
          Icon(Icons.description_outlined, size: 44.sp, color: const Color(0xFF8A8A8A)),
          SizedBox(height: 8.h),
          Text(
            'No pending listings',
            style: AppFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.authTextPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Create your first listing to get started',
            textAlign: TextAlign.center,
            style: AppFonts.inter(
              fontSize: 16.sp,
              color: const Color(0xFF9A9A9A),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 32.h,
            child: ElevatedButton(
              onPressed: onCreateTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF19A7B5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.w),
              ),
              child: Text(
                'Create Listing',
                style: AppFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

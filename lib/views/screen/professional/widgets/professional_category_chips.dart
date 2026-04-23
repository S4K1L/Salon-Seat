import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionalCategoryChips extends StatelessWidget {
  const ProfessionalCategoryChips({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: selected ? AppColors.authAccent : Colors.white,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: selected ? AppColors.authAccent : const Color(0xFFE0E0E0),
                ),
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: AppFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : AppColors.authTextSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

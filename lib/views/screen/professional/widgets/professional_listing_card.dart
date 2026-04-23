import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/professional_browse_listing.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionalListingCard extends StatelessWidget {
  const ProfessionalListingCard({
    super.key,
    required this.listing,
    required this.onTap,
  });

  final ProfessionalBrowseListing listing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    listing.imageUrl,
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100.w,
                      height: 100.w,
                      color: const Color(0xFFE8E8E8),
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listing.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.inter(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        listing.location,
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.authTextSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999.r),
                              border: Border.all(
                                color: AppColors.authAccent,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              listing.category,
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.authAccent,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            listing.priceLabel,
                            style: AppFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.authAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/listings_controller.dart';
import 'package:flutter_extension/data/model/listing_item_model.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/listing_widgets.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_extension/views/screen/listings/listing_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListingsScreen extends StatelessWidget {
  const ListingsScreen({super.key});

  Future<void> _showPauseDialog(
    BuildContext context,
    ListingsController controller,
    ListingItem item,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pause Listing?',
                      style: AppFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Text(
                'Your listing will be hidden from search results until you resume it.',
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFE3E3E3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.pauseListing(item.id);
                          Navigator.of(dialogContext).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF19A7B5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Pause',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: Colors.white,
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
      ),
    );
  }

  Future<void> _showDeleteDialog(
    BuildContext context,
    ListingsController controller,
    ListingItem item,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Delete Listing?',
                      style: AppFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF3C3C),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Text(
                'This action cannot be undone. Your listing will be permanently deleted.',
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFE3E3E3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.deleteListing(item.id);
                          Navigator.of(dialogContext).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFF44343),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: Colors.white,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListingsController>(
      init: ListingsController(),
      global: false,
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.authBackground,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Listings',
                      style: AppFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 38.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.filters.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8.w),
                        itemBuilder: (context, index) => ListingsFilterChip(
                          label: controller.filters[index],
                          selected: controller.activeFilterIndex == index,
                          onTap: () => controller.onFilterTap(index),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    if (controller.visibleListings.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: ListingsEmptyStateCard(
                          onCreateTap: () => Get.toNamed(AppRoutes.createListingScreen),
                        ),
                      )
                    else
                      ...controller.visibleListings.map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: ListingCard(
                            item: item,
                            onViewTap: () => Get.to(
                              () => ListingDetailScreen(
                                item: item,
                                isEditMode: false,
                              ),
                            ),
                            onEditTap: () => Get.to(
                              () => ListingDetailScreen(
                                item: item,
                                isEditMode: true,
                                onSave: controller.updateListing,
                              ),
                            ),
                            onPauseTap: () =>
                                _showPauseDialog(context, controller, item),
                            onDeleteTap: () =>
                                _showDeleteDialog(context, controller, item),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: PrimaryFilledButton(
                label: 'Create New Listing',
                onPressed: () => Get.toNamed(AppRoutes.createListingScreen),
                enabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

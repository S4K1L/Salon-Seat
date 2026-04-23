import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/tour_request_controller.dart';
import 'package:flutter_extension/data/model/tour_request_item_model.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TourRequestScreen extends StatelessWidget {
  const TourRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 12.h),
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
                    'Tour Request',
                    style: AppFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              GetBuilder<TourRequestController>(
                builder: (controller) => _TabBar(
                  activeTab: controller.activeTab,
                  onChanged: controller.changeTab,
                ),
              ),
              SizedBox(height: 18.h),
              Expanded(
                child: GetBuilder<TourRequestController>(
                  builder: (controller) {
                    final filtered = controller.filteredItems;
                    if (filtered.isEmpty) {
                      return Center(
                        child: Text(
                          controller.activeTab == TourRequestStatus.requested
                              ? 'No requested tours'
                              : 'No confirmed tours',
                          style: AppFonts.inter(
                            fontSize: 14.sp,
                            color: AppColors.authTextSecondary,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return _TourRequestCard(
                          item: item,
                          showActions:
                              controller.activeTab ==
                              TourRequestStatus.requested,
                          onAccept: () => controller.acceptRequest(item),
                          onReject: () => controller.rejectRequest(item),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.activeTab, required this.onChanged});

  final TourRequestStatus activeTab;
  final ValueChanged<TourRequestStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabChip(
          label: 'Requested',
          selected: activeTab == TourRequestStatus.requested,
          onTap: () => onChanged(TourRequestStatus.requested),
        ),
        SizedBox(width: 8.w),
        _TabChip(
          label: 'Confirmed',
          selected: activeTab == TourRequestStatus.confirmed,
          onTap: () => onChanged(TourRequestStatus.confirmed),
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.authAccent : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            fontSize: 13.sp,
            color: selected ? Colors.white : AppColors.authTextSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _TourRequestCard extends StatelessWidget {
  const _TourRequestCard({
    required this.item,
    required this.showActions,
    required this.onAccept,
    required this.onReject,
  });

  final TourRequestItemModel item;
  final bool showActions;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Images.placeholder),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    item.name,
                    style: AppFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Listing: ${item.listing}',
            style: AppFonts.inter(
              fontSize: 16.sp,
              color: AppColors.authTextPrimary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16.sp,
                color: AppColors.authTextPrimary,
              ),
              SizedBox(width: 8.w),
              Text(
                item.date,
                style: AppFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.authTextPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 16.sp,
                color: AppColors.authTextPrimary,
              ),
              SizedBox(width: 8.w),
              Text(
                item.time,
                style: AppFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.authTextPrimary,
                ),
              ),
            ],
          ),
          if (showActions) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Reject',
                    color: const Color(0xFFD3D3D3),
                    textColor: AppColors.authTextPrimary,
                    onTap: onReject,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _ActionButton(
                    label: 'Accept',
                    color: AppColors.authAccent,
                    textColor: Colors.white,
                    onTap: onAccept,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Text(
          label,
          style: AppFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

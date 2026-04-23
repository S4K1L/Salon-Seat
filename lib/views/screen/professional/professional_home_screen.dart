import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/professional_browse_listing.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/screen/common/notifications/notifications_screen.dart';
import 'package:flutter_extension/views/screen/professional/professional_browse_listing_detail_screen.dart';
import 'package:flutter_extension/views/screen/professional/professional_search_listings_screen.dart';
import 'package:flutter_extension/views/screen/professional/widgets/professional_category_chips.dart';
import 'package:flutter_extension/views/screen/professional/widgets/professional_listing_card.dart';
import 'package:flutter_extension/views/screen/professional/widgets/professional_browse_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalHomeScreen extends StatefulWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  State<ProfessionalHomeScreen> createState() => _ProfessionalHomeScreenState();
}

class _ProfessionalHomeScreenState extends State<ProfessionalHomeScreen> {
  int _categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final visible = filterProfessionalListings(
      source: kProfessionalBrowseListingsSeed,
      categoryIndex: _categoryIndex,
    );

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Hi, Robert',
                    style: AppFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.to(
                    () => ProfessionalSearchListingsScreen(
                      initialCategoryIndex: _categoryIndex,
                    ),
                  ),
                  icon: Icon(Icons.search_rounded, size: 26.sp, color: AppColors.authTextPrimary),
                ),
                IconButton(
                  onPressed: () => Get.to(() => const NotificationsScreen()),
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    size: 26.sp,
                    color: AppColors.authTextPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ProfessionalCategoryChips(
              labels: const ['All', 'Chair', 'Suite', 'Booth'],
              selectedIndex: _categoryIndex,
              onSelected: (i) => setState(() => _categoryIndex = i),
            ),
            SizedBox(height: 14.h),
            ProfessionalBrowseMap(listings: visible),
            SizedBox(height: 18.h),
            Text(
              'Nearby listings',
              style: AppFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.authTextPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            ...visible.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: ProfessionalListingCard(
                  listing: item,
                  onTap: () => Get.to(
                    () => ProfessionalBrowseListingDetailScreen(listing: item),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

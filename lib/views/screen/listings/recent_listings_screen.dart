import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/home_dashboard_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentListingItem {
  const RecentListingItem({
    required this.imageEmoji,
    required this.title,
    required this.location,
    required this.price,
    required this.status,
    required this.active,
  });

  final String imageEmoji;
  final String title;
  final String location;
  final String price;
  final String status;
  final bool active;
}

class RecentListingsScreen extends StatelessWidget {
  const RecentListingsScreen({super.key, required this.items});

  final List<RecentListingItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        title: Text(
          'Recent Listings',
          style: AppFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
        backgroundColor: AppColors.authBackground,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final item = items[index];
          return HomeRecentListingCard(
            imageEmoji: item.imageEmoji,
            title: item.title,
            location: item.location,
            price: item.price,
            status: item.status,
            active: item.active,
          );
        },
      ),
    );
  }
}

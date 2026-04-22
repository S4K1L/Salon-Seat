import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/home_dashboard_widgets.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_extension/views/screen/listings/recent_listings_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: _DashboardTab(),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  static const _metricItems = <HomeMetricItem>[
    HomeMetricItem(
      svgAssetPath: Images.homeMetricActiveListings,
      iconBg: Color(0xFFD8F5E9),
      value: '3',
      label: 'Active Listings',
    ),
    HomeMetricItem(
      svgAssetPath: Images.homeMetricPendingApproval,
      iconBg: Color(0xFFFFF3D6),
      value: '2',
      label: 'Pending Approval',
    ),
    HomeMetricItem(
      svgAssetPath: Images.homeMetricTotalViews,
      iconBg: Color(0xFFE1EAFF),
      value: '247',
      label: 'Total Views',
    ),
    HomeMetricItem(
      svgAssetPath: Images.homeMetricSaves,
      iconBg: Color(0xFFD8F5E9),
      value: '24',
      label: 'Saves',
    ),
  ];

  static const _recentListings = <RecentListingItem>[
    RecentListingItem(
      imageEmoji: '🏠',
      title: 'Luxury Salon Station',
      location: 'Downtown, Los Angeles',
      price: '\$500/month',
      status: 'Active',
      active: true,
    ),
    RecentListingItem(
      imageEmoji: '💈',
      title: 'Modern Studio Booth',
      location: 'Beverly Hills, Los Angeles',
      price: '\$620/month',
      status: 'Active',
      active: true,
    ),
    RecentListingItem(
      imageEmoji: '💅',
      title: 'Nail Desk Rental',
      location: 'Hollywood, Los Angeles',
      price: '\$420/month',
      status: 'Paused',
      active: false,
    ),
    RecentListingItem(
      imageEmoji: '✂️',
      title: 'Barber Chair Spot',
      location: 'Santa Monica, Los Angeles',
      price: '\$560/month',
      status: 'Active',
      active: true,
    ),
    RecentListingItem(
      imageEmoji: '🧴',
      title: 'Private Beauty Room',
      location: 'Pasadena, Los Angeles',
      price: '\$700/month',
      status: 'Paused',
      active: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeDashboardHeader(),
          SizedBox(height: 12.h),
          
          const HomeMetricGrid(items: _metricItems),
          SizedBox(height: 12.h),
          const HomeCurrentPlanCard(),
          SizedBox(height: 12.h),
          HomeRecentListingsHeader(
            onViewAllTap: () {
              Get.to(() => const RecentListingsScreen(items: _recentListings));
            },
          ),
          SizedBox(height: 8.h),
          ..._recentListings.take(3).map(
            (listing) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: HomeRecentListingCard(
                imageEmoji: listing.imageEmoji,
                title: listing.title,
                location: listing.location,
                price: listing.price,
                status: listing.status,
                active: listing.active,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          PrimaryFilledButton(
            label: 'Create New Listing',
            onPressed: () => Get.toNamed(AppRoutes.createListingScreen),
            enabled: true,
          ),
          SizedBox(height: 8.h),
          PrimaryFilledButton(
            label: 'Boost Listing',
            onPressed: () => Get.toNamed(AppRoutes.listingPlanScreen),
            backgroundColor: const Color(0xFFE5E5E5),
            textColor: const Color(0xFF333333),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/home_dashboard_widgets.dart';
import 'package:flutter_extension/views/base/primary_filled_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          const HomeRecentListingsHeader(),
          SizedBox(height: 8.h),
          const HomeRecentListingCard(
            imageEmoji: '🏠',
            title: 'Luxury Salon Station',
            location: 'Downtown, Los Angeles',
            price: '\$500/month',
            status: 'Active',
            active: true,
          ),
          SizedBox(height: 10.h),
          const HomeRecentListingCard(
            imageEmoji: '💈',
            title: 'Luxury Salon Station',
            location: 'Downtown, Los Angeles',
            price: '\$500/month',
            status: 'Paused',
            active: false,
          ),
          SizedBox(height: 14.h),
          const PrimaryFilledButton(
            label: 'Create New Listing',
            onPressed: null,
            enabled: true,
          ),
          SizedBox(height: 8.h),
          PrimaryFilledButton(
            label: 'Boost Listing',
            onPressed: () {},
            backgroundColor: const Color(0xFFE5E5E5),
            textColor: const Color(0xFF333333),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}


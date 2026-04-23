import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav_bar.dart';
import 'package:flutter_extension/views/screen/owner/analytics/analytics_screen.dart';
import 'package:flutter_extension/views/screen/owner/home/home_screen.dart';
import 'package:flutter_extension/views/screen/owner/listings/listings_screen.dart';
import 'package:flutter_extension/views/screen/common/messages/messages_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/settings_screen.dart';

class OwnerNavScreen extends StatelessWidget {
  const OwnerNavScreen({super.key});

  static const _tabs = <BottomNavBarItem>[
    BottomNavBarItem(label: 'Dashboard', svgAssetPath: Images.navDashboard),
    BottomNavBarItem(label: 'Listings', svgAssetPath: Images.navListings),
    BottomNavBarItem(label: 'Message', svgAssetPath: Images.navMessage),
    BottomNavBarItem(label: 'Analytics', svgAssetPath: Images.navAnalytics),
    BottomNavBarItem(label: 'Settings', svgAssetPath: Images.navSettings),
  ];

  @override
  Widget build(BuildContext context) {
    return const CustomBottomNavScaffold(
      items: _tabs,
      pages: [
        HomeScreen(),
        ListingsScreen(),
        MessagesScreen(),
        AnalyticsScreen(),
        SettingsScreen(),
      ],
      backgroundColor: AppColors.authBackground,
    );
  }
}

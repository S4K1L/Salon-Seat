import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav_bar.dart';
import 'package:flutter_extension/views/screen/home/home_screen.dart';
import 'package:flutter_extension/views/screen/listings/listings_screen.dart';
import 'package:flutter_extension/views/screen/settings/settings_screen.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

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
        _PlaceholderTab(title: 'Message'),
        _PlaceholderTab(title: 'Analytics'),
        SettingsScreen(),
      ],
      backgroundColor: AppColors.authBackground,
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}

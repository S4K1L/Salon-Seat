import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/custom_bottom_nav_bar.dart';
import 'package:flutter_extension/views/screen/professional/professional_browse_listings_screen.dart';
import 'package:flutter_extension/views/screen/professional/professional_home_screen.dart';
import 'package:flutter_extension/views/screen/common/messages/messages_screen.dart';
import 'package:flutter_extension/views/screen/common/settings/settings_screen.dart';

class ProfessionalNavbar extends StatelessWidget {
  const ProfessionalNavbar({super.key});

  static const _tabs = <BottomNavBarItem>[
    BottomNavBarItem(label: 'Home', svgAssetPath: Images.navDashboard),
    BottomNavBarItem(label: 'Listings', svgAssetPath: Images.navListings),
    BottomNavBarItem(label: 'Message', svgAssetPath: Images.navMessage),
    BottomNavBarItem(label: 'Settings', svgAssetPath: Images.navSettings),
  ];

  @override
  Widget build(BuildContext context) {
    return const CustomBottomNavScaffold(
      items: _tabs,
      pages: [
        ProfessionalHomeScreen(),
        ProfessionalBrowseListingsScreen(),
        MessagesScreen(),
        SettingsScreen(),
      ],
      backgroundColor: AppColors.authBackground,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarItem {
  const BottomNavBarItem({
    required this.label,
    this.icon,
    this.svgAssetPath,
  });

  final String label;
  final IconData? icon;
  final String? svgAssetPath;
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
  });

  final int currentIndex;
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: List.generate(
            items.length,
            (index) {
              final selected = index == currentIndex;
              final item = items[index];
              return Expanded(
                child: InkWell(
                  onTap: () => onChanged(index),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      item.svgAssetPath != null
                          ? SvgPicture.asset(
                              item.svgAssetPath!,
                              width: 24.w,
                              height: 24.w,
                              colorFilter: ColorFilter.mode(
                                selected
                                    ? AppColors.authAccent
                                    : AppColors.authTextSecondary,
                                BlendMode.srcIn,
                              ),
                            )
                          : Icon(
                              item.icon ?? Icons.circle,
                              size: 24.sp,
                              color: selected
                                  ? AppColors.authAccent
                                  : AppColors.authTextSecondary,
                            ),
                      SizedBox(height: 2.h),
                      Text(
                        item.label,
                        style: AppFonts.inter(
                          fontSize: 11.sp,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w500,
                          color: selected
                              ? AppColors.authAccent
                              : AppColors.authTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavScaffold extends StatefulWidget {
  const CustomBottomNavScaffold({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
    this.backgroundColor = AppColors.authBackground,
  });

  final List<BottomNavBarItem> items;
  final List<Widget> pages;
  final int initialIndex;
  final Color backgroundColor;

  @override
  State<CustomBottomNavScaffold> createState() => _CustomBottomNavScaffoldState();
}

class _CustomBottomNavScaffoldState extends State<CustomBottomNavScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.items.length == widget.pages.length,
      'Bottom-nav items/pages length mismatch',
    );

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: widget.pages),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: widget.items,
        onChanged: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

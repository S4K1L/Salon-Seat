import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/professional_browse_listing.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/screen/professional/professional_browse_listing_detail_screen.dart';
import 'package:flutter_extension/views/screen/professional/widgets/professional_category_chips.dart';
import 'package:flutter_extension/views/screen/professional/widgets/professional_listing_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalSearchListingsScreen extends StatefulWidget {
  const ProfessionalSearchListingsScreen({
    super.key,
    this.initialCategoryIndex = 0,
  });

  final int initialCategoryIndex;

  @override
  State<ProfessionalSearchListingsScreen> createState() =>
      _ProfessionalSearchListingsScreenState();
}

class _ProfessionalSearchListingsScreenState extends State<ProfessionalSearchListingsScreen> {
  late int _categoryIndex;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryIndex = widget.initialCategoryIndex.clamp(0, 3);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filterProfessionalListings(
      source: kProfessionalBrowseListingsSeed,
      categoryIndex: _categoryIndex,
      query: _searchController.text,
    );

    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        backgroundColor: AppColors.authBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Search',
          style: AppFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfessionalCategoryChips(
              labels: const ['All', 'Chair', 'Suite', 'Booth'],
              selectedIndex: _categoryIndex,
              onSelected: (i) => setState(() => _categoryIndex = i),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search by name, city name or ZIP......',
                hintStyle: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authHint,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search_rounded, color: AppColors.authAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.authAccent),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  return ProfessionalListingCard(
                    listing: item,
                    onTap: () => Get.to(
                      () => ProfessionalBrowseListingDetailScreen(listing: item),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

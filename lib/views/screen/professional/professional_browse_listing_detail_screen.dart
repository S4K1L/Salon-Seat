import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/professional_browse_listing.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/screen/common/messages/chat_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalBrowseListingDetailScreen extends StatefulWidget {
  const ProfessionalBrowseListingDetailScreen({super.key, required this.listing});

  final ProfessionalBrowseListing listing;

  @override
  State<ProfessionalBrowseListingDetailScreen> createState() =>
      _ProfessionalBrowseListingDetailScreenState();
}

class _ProfessionalBrowseListingDetailScreenState
    extends State<ProfessionalBrowseListingDetailScreen> {
  late final PageController _pageController;
  int _page = 0;
  bool _bookmarked = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _openScheduleTour() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _ScheduleTourDialog(
        onRequest: () {
          Navigator.of(dialogContext).pop();
          Get.showSnackbar(
            GetSnackBar(
              messageText: Text(
                'Tour request sent',
                style: AppFonts.inter(color: Colors.white, fontSize: 14.sp),
              ),
              backgroundColor: Colors.black87,
              duration: const Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.all(12.w),
              borderRadius: 8,
            ),
          );
        },
      ),
    );
  }

  void _openMessage() {
    Get.to(
      () => ChatDetailScreen(
        name: widget.listing.ownerName,
        avatarEmoji: '💬',
        verified: widget.listing.ownerVerified,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.listing.galleryUrls;
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
          'Listing Detail',
          style: AppFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: SizedBox(
                      height: 220.h,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: urls.length,
                            onPageChanged: (i) => setState(() => _page = i),
                            itemBuilder: (context, i) => Image.network(
                              urls[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFE8E8E8),
                                child: const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                urls.length,
                                (i) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  width: i == _page ? 8.w : 6.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: i == _page
                                        ? AppColors.authAccent
                                        : Colors.white.withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.listing.title,
                          style: AppFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _bookmarked = !_bookmarked),
                        icon: Icon(
                          _bookmarked ? Icons.bookmark : Icons.bookmark_border_rounded,
                          color: AppColors.authTextPrimary,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.listing.description,
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      height: 1.45,
                      color: AppColors.authTextSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    widget.listing.priceDetail,
                    style: AppFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(color: AppColors.authAccent),
                    ),
                    child: Text(
                      widget.listing.rentalType,
                      style: AppFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      widget.listing.mapLocationLabel,
                      style: AppFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2B7FFF),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Owner: ${widget.listing.ownerName}',
                        style: AppFonts.inter(
                          fontSize: 14.sp,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                      if (widget.listing.ownerVerified) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.authAccent),
                          ),
                          child: Text(
                            'Verified',
                            style: AppFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.authAccent,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Availability: ${widget.listing.availability}',
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      color: AppColors.authTextSecondary,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Amenities',
                    style: AppFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: widget.listing.amenities
                        .map(
                          (a) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F6F7),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              a,
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
            decoration: BoxDecoration(
              color: AppColors.authBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: _openScheduleTour,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8E8E8),
                          foregroundColor: AppColors.authTextPrimary,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Schedule Tour',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: _openMessage,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.authAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Message',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleTourDialog extends StatelessWidget {
  const _ScheduleTourDialog({required this.onRequest});

  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Schedule a Tour',
              textAlign: TextAlign.center,
              style: AppFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.authTextPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _LabeledField(
                    label: 'Date',
                    hint: 'Pick date',
                    icon: Icons.calendar_today_outlined,
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _LabeledField(
                    label: 'Time',
                    hint: 'Pick time',
                    icon: Icons.access_time_rounded,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              'Add Note (Optional)',
              style: AppFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Start typing...',
                hintStyle: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authHint,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xFFDADADA)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Color(0xFFDADADA)),
                ),
                contentPadding: EdgeInsets.all(12.w),
              ),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              height: 48.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: onRequest,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Request Tour',
                    style: AppFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String hint;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.authTextSecondary,
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFDADADA)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hint,
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      color: AppColors.authHint,
                    ),
                  ),
                ),
                Icon(icon, size: 18.sp, color: AppColors.authTextSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

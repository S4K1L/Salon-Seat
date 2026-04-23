import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/home_dashboard_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics',
              style: AppFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authTextPrimary,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Last 30 days',
              style: AppFonts.inter(
                fontSize: 13.sp,
                color: AppColors.authTextSecondary,
              ),
            ),
           
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeMetricGrid(items: _metricItems),
            SizedBox(height: 12.h),
            const _ChartCard(title: 'Weekly Views', child: _WeeklyViewsChart()),
            SizedBox(height: 12.h),
            const _ChartCard(
              title: 'Monthly Inquiries',
              child: _MonthlyInquiriesChart(),
            ),
            SizedBox(height: 12.h),
            const _TopPerformingListingsCard(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.authTextPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}

class _WeeklyViewsChart extends StatelessWidget {
  const _WeeklyViewsChart();

  static const _data = <double>[45, 52, 38, 68, 80, 96, 72];
  static const _labels = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: _LineChartPainter(values: _data),
              child: Container(),
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _labels
                  .map(
                    (e) => Text(
                      e,
                      style: AppFonts.inter(
                        fontSize: 10.sp,
                        color: AppColors.authTextSecondary,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({required this.values});

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    const leftPad = 26.0;
    const rightPad = 10.0;
    const topPad = 8.0;
    const bottomPad = 8.0;
    final chartWidth = size.width - leftPad - rightPad;
    final chartHeight = size.height - topPad - bottomPad;

    final gridPaint = Paint()
      ..color = const Color(0xFFE9EDF3)
      ..strokeWidth = 1;
    final axisPaint = Paint()
      ..color = const Color(0xFFAAB3BE)
      ..strokeWidth = 1.2;

    for (int i = 0; i < 5; i++) {
      final y = topPad + (chartHeight * i / 4);
      canvas.drawLine(
        Offset(leftPad, y),
        Offset(size.width - rightPad, y),
        gridPaint,
      );
    }

    canvas.drawLine(
      const Offset(leftPad, topPad),
      Offset(leftPad, size.height - bottomPad),
      axisPaint,
    );
    canvas.drawLine(
      Offset(leftPad, size.height - bottomPad),
      Offset(size.width - rightPad, size.height - bottomPad),
      axisPaint,
    );

    final minV = values.reduce(math.min);
    final maxV = values.reduce(math.max);
    final span = (maxV - minV).abs() < 0.01 ? 1.0 : (maxV - minV);

    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = leftPad + chartWidth * i / (values.length - 1);
      final normalized = (values[i] - minV) / span;
      final y = topPad + chartHeight - (normalized * chartHeight);
      points.add(Offset(x, y));
    }

    final linePaint = Paint()
      ..color = AppColors.authAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final dotPaint = Paint()..color = AppColors.authAccent;
    final dotBorderPaint = Paint()..color = Colors.white;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    for (final p in points) {
      canvas.drawCircle(p, 3.2, dotBorderPaint);
      canvas.drawCircle(p, 2.2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.values != values;
}

class _MonthlyInquiriesChart extends StatelessWidget {
  const _MonthlyInquiriesChart();

  static const _bars = <double>[8, 12, 9, 14];
  static const _labels = <String>['Week 1', 'Week 2', 'Week 3', 'Week 4'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                _bars.length,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Container(
                      height: (_bars[index] / 14) * 96.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF20B484),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _labels
                .map(
                  (e) => Text(
                    e,
                    style: AppFonts.inter(
                      fontSize: 10.sp,
                      color: AppColors.authTextSecondary,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TopPerformingListingsCard extends StatelessWidget {
  const _TopPerformingListingsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(),
          SizedBox(height: 10),
          _TopListingTile(
            emoji: '💇',
            title: 'Luxury Salon Station',
            views: '452 views',
            progress: 0.78,
            percent: '78%',
          ),
          SizedBox(height: 8),
          _TopListingTile(
            emoji: '🪑',
            title: 'Modern Chair Rental',
            views: '389 views',
            progress: 0.45,
            percent: '45%',
          ),
          SizedBox(height: 8),
          _TopListingTile(
            emoji: '💄',
            title: 'Boutique Salon Space',
            views: '276 views',
            progress: 0.92,
            percent: '92%',
          ),
        ],
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Top Performing Listings',
      style: AppFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A4E85),
      ),
    );
  }
}

class _TopListingTile extends StatelessWidget {
  const _TopListingTile({
    required this.emoji,
    required this.title,
    required this.views,
    required this.progress,
    required this.percent,
  });

  final String emoji;
  final String title;
  final String views;
  final double progress;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFE7E7E7), Color(0xFFCBCBCB)],
              ),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: TextStyle(fontSize: 16.sp)),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.authTextPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  views,
                  style: AppFonts.inter(
                    fontSize: 12.sp,
                    color: AppColors.authTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            width: 62.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: const Color(0xFFE3E8ED),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.authAccent,
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            percent,
            style: AppFonts.inter(
              fontSize: 12.sp,
              color: AppColors.authTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

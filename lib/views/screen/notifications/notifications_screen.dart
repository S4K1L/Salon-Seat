import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationItem {
  NotificationItem({
    required this.id,
    required this.message,
    required this.timeAgo,
    required this.isRead,
  });

  final String id;
  final String message;
  final String timeAgo;
  final bool isRead;
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<NotificationItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      NotificationItem(
        id: '1',
        message:
            'Reminder: Your booth viewing is tomorrow at 10:00 AM',
        timeAgo: '5 minutes ago',
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        message:
            "It's almost time! Your salon station tour is in 2 hours",
        timeAgo: '5 minutes ago',
        isRead: false,
      ),
      NotificationItem(
        id: '3',
        message:
            'Limited-time offer! Get 10% off your next listing upgrade',
        timeAgo: '1 hour ago',
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        message:
            'Flash promotion: Save up to 20% on featured listings — book now!',
        timeAgo: '1 hour ago',
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        message:
            'Your reserved station is ready! Contact us to finalize booking',
        timeAgo: '1 hour ago',
        isRead: true,
      ),
      NotificationItem(
        id: '6',
        message:
            "We've received your application! It's processing and will update soon",
        timeAgo: '1 hour ago',
        isRead: true,
      ),
      NotificationItem(
        id: '7',
        message:
            'New version of the app is available! Update now to enjoy new features',
        timeAgo: '1 hour ago',
        isRead: true,
      ),
    ];
  }

  void _removeAt(int index) {
    setState(() => _items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        backgroundColor: AppColors.authBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: AppColors.authTextPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: AppFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.authTextPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: _items.isEmpty
          ? Center(
              child: Text(
                'No notifications',
                style: AppFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 4.h, 0, 16.h),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: ValueKey<String>(item.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: AppColors.authBorderError,
                    padding: EdgeInsets.only(right: 24.w),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ),
                  onDismissed: (_) => _removeAt(index),
                  child: _NotificationListTile(item: item),
                );
              },
            ),
    );
  }
}

class _NotificationListTile extends StatelessWidget {
  const _NotificationListTile({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    final unread = !item.isRead;
    final rowBg = unread
        ? AppColors.primarySwatch[100]!.withValues(alpha: 0.45)
        : AppColors.authBackground;
    final iconCircleBg =
        unread ? Colors.white : AppColors.primarySwatch[50]!;

    return ColoredBox(
      color: rowBg,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconCircleBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 22.sp,
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.message,
                      style: AppFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authTextPrimary,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14.sp,
                          color: AppColors.authTextSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          item.timeAgo,
                          style: AppFonts.inter(
                            fontSize: 13.sp,
                            color: AppColors.authTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

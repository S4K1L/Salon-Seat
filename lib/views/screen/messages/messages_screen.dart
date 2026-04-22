import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/screen/messages/chat_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  static const _items = <_ChatItem>[
    _ChatItem(
      name: 'Sarah',
      message: 'Is the station still available?',
      time: '2m ago',
      verified: true,
      unreadCount: 2,
      avatarEmoji: '👩',
    ),
    _ChatItem(
      name: 'Mike Chen jamid ibne hamad',
      message: 'Can I schedule a viewing?',
      time: '1h ago',
      verified: true,
      avatarEmoji: '👩‍🦱',
    ),
    _ChatItem(
      name: 'Emma Davis',
      message: 'Thanks for the info!',
      time: '3h ago',
      avatarEmoji: '👨',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 10.h),
          child: Text(
            'Messages',
            style: AppFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.authTextPrimary,
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.authBorder),
        Expanded(
          child: ListView.separated(
            itemCount: _items.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, thickness: 1, color: AppColors.authBorder),
            itemBuilder: (context, index) => _ChatTile(
              item: _items[index],
              onTap: () => Get.to(
                () => ChatDetailScreen(
                  name: _items[index].name,
                  avatarEmoji: _items[index].avatarEmoji,
                  verified: _items[index].verified,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.item, required this.onTap});

  final _ChatItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 58.w,
              height: 58.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFF0F0F0), Color(0xFFD5D5D5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Text(item.avatarEmoji, style: TextStyle(fontSize: 24.sp)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: AppFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.authTextPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.verified) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF9C3),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16.sp,
                                color: const Color(0xFFEAB308),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Verified',
                                style: AppFonts.inter(
                                  fontSize: 14.sp,
                                  color: const Color(0xFFEAB308),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        item.time,
                        style: AppFonts.inter(
                          fontSize: 13.sp,
                          color: AppColors.authTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: AppColors.authTextSecondary,
                          ),
                        ),
                      ),
                      if (item.unreadCount > 0) ...[
                        SizedBox(width: 8.w),
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.authAccent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${item.unreadCount}',
                            style: AppFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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

class _ChatItem {
  const _ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarEmoji,
    this.verified = false,
    this.unreadCount = 0,
  });

  final String name;
  final String message;
  final String time;
  final String avatarEmoji;
  final bool verified;
  final int unreadCount;
}

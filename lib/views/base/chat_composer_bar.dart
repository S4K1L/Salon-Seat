import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatComposerBar extends StatelessWidget {
  const ChatComposerBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
    required this.onEmoji,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final VoidCallback onEmoji;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onAttach,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
            icon: Icon(
              Icons.attach_file_rounded,
              size: 24.sp,
              color: AppColors.authTextSecondary,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.authFieldFill,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFFC4C4C4)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 3,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                      style: AppFonts.inter(
                        fontSize: 16.sp,
                        color: AppColors.authTextPrimary,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your messages...',
                        hintStyle: AppFonts.inter(
                          fontSize: 16.sp,
                          color: AppColors.authHint,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onEmoji,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
                    icon: Icon(
                      Icons.emoji_emotions_rounded,
                      size: 22.sp,
                      color: AppColors.authTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: AppColors.authBorder,
                borderRadius: BorderRadius.circular(14.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.send_rounded,
                size: 22.sp,
                color: AppColors.authTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

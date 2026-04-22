import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/chat_input_helpers.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/views/base/chat_composer_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.avatarEmoji,
    this.verified = false,
  });

  final String name;
  final String avatarEmoji;
  final bool verified;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final List<ChatMessageModel> _messages = [
    const ChatMessageModel(
      text: 'Hi! I saw your listing for the salon station',
      time: '11:00 AM',
      isOutgoing: false,
    ),
    const ChatMessageModel(
      text: "Hello! Yes, it's still available. Would you like to know more?",
      time: '10:55 AM',
      isOutgoing: true,
    ),
    const ChatMessageModel(
      text: 'Yes please! Is the station still available in downtown LA?',
      time: '11:00 AM',
      isOutgoing: false,
    ),
    const ChatMessageModel(
      text:
          "Yes, it's the luxury station on Main Street. It includes a chair, mirror, and storage.",
      time: '10:55 AM',
      isOutgoing: true,
    ),
    const ChatMessageModel(
      text: 'That sounds perfect! Can I schedule a viewing?',
      time: '11:00 AM',
      isOutgoing: false,
    ),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(
        ChatMessageModel(
          text: text,
          time: _formatTime(TimeOfDay.now()),
          isOutgoing: true,
        ),
      );
    });
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120.h,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _attachGalleryImage() async {
    final path = await pickGalleryImagePath(context);
    if (!mounted || path == null) return;
    setState(() {
      _messages.add(
        ChatMessageModel(
          text: '',
          imagePath: path,
          time: _formatTime(TimeOfDay.now()),
          isOutgoing: true,
        ),
      );
    });
    _scrollToBottom();
  }

  void _openEmojiPicker() {
    showEmojiPickerSheet(context, _messageController);
  }

  String _formatTime(TimeOfDay time) {
    final h = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final m = time.minute.toString().padLeft(2, '0');
    final suffix = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $suffix';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(
              name: widget.name,
              avatarEmoji: widget.avatarEmoji,
              verified: widget.verified,
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.authBorder),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                children: _messages
                    .map(
                      (message) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          message.isOutgoing
                              ? _OutgoingMessage(
                                  text: message.text,
                                  imagePath: message.imagePath,
                                )
                              : _IncomingMessage(
                                  text: message.text,
                                  avatarEmoji: widget.avatarEmoji,
                                  imagePath: message.imagePath,
                                ),
                          _MessageTime(
                            text: message.time,
                            isOutgoing: message.isOutgoing,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.authBorder),
            ChatComposerBar(
              controller: _messageController,
              onSend: _sendMessage,
              onAttach: () {
                _attachGalleryImage();
              },
              onEmoji: _openEmojiPicker,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.name,
    required this.avatarEmoji,
    required this.verified,
  });

  final String name;
  final String avatarEmoji;
  final bool verified;

  Future<void> _showBlockUserDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Block User?',
                      style: AppFonts.inter(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close_rounded, color: AppColors.authTextPrimary),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'You won\'t receive messages from this user anymore.',
                style: AppFonts.inter(
                  fontSize: 14.sp,
                  color: AppColors.authTextSecondary,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42.h,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFE5E5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: AppColors.authTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SizedBox(
                      height: 42.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Get.showSnackbar(
                            const GetSnackBar(
                              messageText: Text(
                                'User blocked',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black87,
                              duration: Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.all(12),
                              borderRadius: 8,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFEF4444),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Block',
                          style: AppFonts.inter(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showChatOptionsDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chat Options',
                      style: AppFonts.inter(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close_rounded, color: AppColors.authTextPrimary),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  Get.showSnackbar(
                    const GetSnackBar(
                      messageText: Text(
                        'View profile coming soon',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black87,
                      duration: Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(12),
                      borderRadius: 8,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(
                    'View Profile',
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  _showBlockUserDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(
                    'Block User',
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  Get.showSnackbar(
                    const GetSnackBar(
                      messageText: Text(
                        'Report submitted',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black87,
                      duration: Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(12),
                      borderRadius: 8,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(
                    'Report Conversation',
                    style: AppFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 10.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded, color: AppColors.authTextPrimary),
          ),
          Container(
            width: 46.w,
            height: 46.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFF0F0F0), Color(0xFFD5D5D5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(avatarEmoji, style: TextStyle(fontSize: 22.sp)),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.authTextPrimary,
                        ),
                      ),
                    ),
                    if (verified)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              size: 14.sp,
                              color: const Color(0xFFEAB308),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Verified',
                              style: AppFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFFEAB308),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Text(
                  'Active now',
                  style: AppFonts.inter(
                    fontSize: 13.sp,
                    color: AppColors.authTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showChatOptionsDialog(context),
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.authTextPrimary),
          ),
        ],
      ),
    );
  }
}

class _IncomingMessage extends StatelessWidget {
  const _IncomingMessage({
    required this.text,
    required this.avatarEmoji,
    this.imagePath,
  });

  final String text;
  final String avatarEmoji;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    final hasText = text.isNotEmpty;
    if (!hasImage && !hasText) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.w,
          height: 28.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFF0F0F0), Color(0xFFD5D5D5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: Text(avatarEmoji, style: TextStyle(fontSize: 12.sp)),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFC4C4C4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(imagePath!),
                      width: 220.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (hasImage && hasText) SizedBox(height: 8.h),
                if (hasText)
                  Text(
                    text,
                    style: AppFonts.inter(
                      fontSize: 16.sp,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OutgoingMessage extends StatelessWidget {
  const _OutgoingMessage({required this.text, this.imagePath});

  final String text;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    final hasText = text.isNotEmpty;
    if (!hasImage && !hasText) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.82.sw),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.authAccent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  File(imagePath!),
                  width: 220.w,
                  fit: BoxFit.cover,
                ),
              ),
            if (hasImage && hasText) SizedBox(height: 8.h),
            if (hasText)
              Text(
                text,
                style: AppFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MessageTime extends StatelessWidget {
  const _MessageTime({required this.text, required this.isOutgoing});

  final String text;
  final bool isOutgoing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(isOutgoing ? 40.w : 40, 8.h, isOutgoing ? 0 : 40.w, 14.h),
      child: Align(
        alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          text,
          style: AppFonts.inter(
            fontSize: 14.sp,
            color: AppColors.authTextSecondary,
          ),
        ),
      ),
    );
  }
}

class ChatMessageModel {
  const ChatMessageModel({
    required this.text,
    required this.time,
    required this.isOutgoing,
    this.imagePath,
  });

  final String text;
  final String time;
  final bool isOutgoing;
  final String? imagePath;
}

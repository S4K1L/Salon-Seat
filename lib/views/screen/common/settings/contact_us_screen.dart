import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/chat_input_helpers.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_fonts.dart';
import 'package:flutter_extension/util/images.dart';
import 'package:flutter_extension/views/base/chat_composer_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: "Hello! Yes, it's still available. Would you like to know more?",
      time: '10:55 AM',
      isOutgoing: true,
    ),
    const _ChatMessage(
      text: 'Yes please! Is the station still available in downtown LA?',
      time: '11:00 AM',
      isOutgoing: false,
    ),
    const _ChatMessage(
      text:
          "Yes, it's the luxury station on Main Street. It includes a chair, mirror, and storage.",
      time: '10:55 AM',
      isOutgoing: true,
    ),
    const _ChatMessage(
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
        _ChatMessage(
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
        _ChatMessage(
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
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 10.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.authTextPrimary,
                    ),
                  ),
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF111111),
                      border: Border.all(
                        color: AppColors.authBorder,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Images.iconSalon,
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'SalonSeat',
                      style: AppFonts.inter(
                        fontSize: 30.sp / 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.authTextPrimary,
                      ),
                    ),
                  ),
                ],
              ),
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

class _IncomingMessage extends StatelessWidget {
  const _IncomingMessage({required this.text, this.imagePath});

  final String text;
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
            color: Color(0xFF111111),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            Images.iconSalon,
            width: 14.w,
            height: 14.w,
            fit: BoxFit.contain,
          ),
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


class _ChatMessage {
  const _ChatMessage({
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

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String?> pickGalleryImagePath(BuildContext context) async {
  final granted = await _ensureGalleryPermission(context);
  if (!granted) return null;

  try {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    return file?.path;
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the gallery: $e')),
      );
    }
    return null;
  }
}

Future<bool> _ensureGalleryPermission(BuildContext context) async {
  if (kIsWeb) return true;

  if (Platform.isIOS) {
    final status = await Permission.photos.request();
    final ok = status.isGranted || status.isLimited;
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Allow photo library access to attach images.'),
        ),
      );
    }
    return ok;
  }

  if (Platform.isAndroid) {
    final sdk = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    // Android 13+ photo picker does not require READ_MEDIA_IMAGES.
    if (sdk >= 33) {
      return true;
    }
    final status = await Permission.storage.request();
    if (status.isGranted) return true;
    if (context.mounted) {
      if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Allow storage access to attach images.'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Allow storage access to attach images.'),
          ),
        );
      }
    }
    return false;
  }

  return true;
}

void showEmojiPickerSheet(BuildContext context, TextEditingController controller) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      final bottom = MediaQuery.viewInsetsOf(ctx).bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: SafeArea(
          child: SizedBox(
            height: 320,
            child: EmojiPicker(
              textEditingController: controller,
              config: const Config(height: 256),
            ),
          ),
        ),
      );
    },
  );
}

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  String? selectedImagePath;

  Future<void> pickProfileImage() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    final pickedPath = result?.files.single.path;
    if (pickedPath == null || pickedPath.isEmpty) return;
    selectedImagePath = pickedPath;
    update();
  }
}

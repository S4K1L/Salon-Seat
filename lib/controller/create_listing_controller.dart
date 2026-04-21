import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UploadedLocalFile {
  UploadedLocalFile({
    required this.name,
    required this.sizeInBytes,
    this.path,
  });

  final String name;
  final int sizeInBytes;
  final String? path;

  String get sizeLabel {
    final sizeMb = sizeInBytes / (1024 * 1024);
    return '${sizeMb.toStringAsFixed(2)} MB';
  }
}

class CreateListingController extends GetxController {
  int _step = 0;
  int get step => _step;

  static const List<String> stepTitles = <String>[
    'Basic Information',
    'Amenities & Features',
    'Rental Details',
    'Photos & Media',
    'Policies / Notes',
  ];

  static const List<String> amenities = <String>[
    'Wi-Fi',
    'Parking',
    'Storage',
    'Mirror',
    'Sink',
    'Styling Chair',
    'Product Shelves',
    '24/7 Access',
  ];

  final Set<String> selectedAmenities = <String>{};
  String? rentalType;
  String? leaseTerms = 'Monthly';
  String? availabilityStatus;
  final List<UploadedLocalFile> uploadedFiles = <UploadedLocalFile>[];

  void nextStep() {
    if (_step < 4) {
      _step += 1;
      update();
    }
  }

  void previousStep() {
    if (_step > 0) {
      _step -= 1;
      update();
    }
  }

  void toggleAmenity(String item) {
    if (selectedAmenities.contains(item)) {
      selectedAmenities.remove(item);
    } else {
      selectedAmenities.add(item);
    }
    update();
  }

  void setRentalType(String? value) {
    rentalType = value;
    update();
  }

  void setLeaseTerms(String? value) {
    leaseTerms = value;
    update();
  }

  void setAvailabilityStatus(String? value) {
    availabilityStatus = value;
    update();
  }

  Future<void> pickFiles({bool replace = false, int? replaceAtIndex}) async {
    final result = await FilePicker.pickFiles(
      allowMultiple: !replace,
      type: FileType.custom,
      allowedExtensions: const <String>['png', 'pdf'],
    );
    if (result == null || result.files.isEmpty) return;

    final picked = result.files
        .map(
          (f) => UploadedLocalFile(
            name: f.name,
            sizeInBytes: f.size,
            path: f.path,
          ),
        )
        .toList();

    if (replace && replaceAtIndex != null && replaceAtIndex >= 0 && replaceAtIndex < uploadedFiles.length) {
      uploadedFiles[replaceAtIndex] = picked.first;
    } else {
      uploadedFiles.addAll(picked);
    }
    update();
  }

  void removeFileAt(int index) {
    if (index < 0 || index >= uploadedFiles.length) return;
    uploadedFiles.removeAt(index);
    update();
  }
}

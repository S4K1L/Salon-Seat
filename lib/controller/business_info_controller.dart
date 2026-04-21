import 'package:flutter/material.dart';
import 'package:flutter_extension/data/model/business_info_model.dart';
import 'package:get/get.dart';

class BusinessInfoController extends GetxController {
  final TextEditingController businessNameController = TextEditingController(
    text: 'Business Name',
  );
  final TextEditingController businessAddressController = TextEditingController(
    text: '123 Main Street',
  );
  final TextEditingController cityController = TextEditingController(
    text: 'Dallas',
  );
  final TextEditingController zipCodeController = TextEditingController(
    text: '75201',
  );

  BusinessInfoModel get currentInfo => BusinessInfoModel(
    businessName: businessNameController.text.trim(),
    businessAddress: businessAddressController.text.trim(),
    city: cityController.text.trim(),
    zipCode: zipCodeController.text.trim(),
  );

  void saveChanges() {
    update();
  }

  @override
  void onClose() {
    businessNameController.dispose();
    businessAddressController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }
}

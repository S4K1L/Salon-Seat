import 'package:get/get.dart';

enum AppUserRole { salonOwner, beautyProfessional }

class ChooseRoleController extends GetxController {
  AppUserRole? chosenRole;

  void setRole(AppUserRole role) {
    chosenRole = role;
  }
}

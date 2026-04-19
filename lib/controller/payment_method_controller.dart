import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

enum AppPaymentMethod { cards, stripe, paypal }

class PaymentMethodController extends GetxController {
  PaymentMethodController({this.planTierIndex = 0});

  final int planTierIndex;

  final selectedMethod = AppPaymentMethod.cards.obs;

  final isLoading = false.obs;

  void select(AppPaymentMethod method) {
    selectedMethod.value = method;
  }

  Future<void> makePayment() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.homeScreen);
  }
}

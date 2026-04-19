import 'package:flutter_extension/helper/route_helper.dart';
import 'package:get/get.dart';

class ListingPlanTier {
  const ListingPlanTier({
    required this.priceMain,
    required this.priceSuffix,
    required this.bullets,
  });

  final String priceMain;
  final String priceSuffix;
  final List<String> bullets;
}

class ListingPlanController extends GetxController {
  static const tiers = [
    ListingPlanTier(
      priceMain: '\$9.99',
      priceSuffix: '/month',
      bullets: ['1 active listing', 'Up to 6 photos'],
    ),
    ListingPlanTier(
      priceMain: '\$14.99',
      priceSuffix: '/month',
      bullets: [
        'Up to 5 listings',
        '12 photos per listing',
        'Basic analytics',
      ],
    ),
    ListingPlanTier(
      priceMain: '\$19.99',
      priceSuffix: '/month',
      bullets: [
        'Unlimited listings',
        '20 photos per listing',
        'Advanced analytics',
      ],
    ),
  ];

  final selectedIndex = 0.obs;

  void select(int index) {
    if (index < 0 || index >= tiers.length) return;
    selectedIndex.value = index;
  }

  void continueToPayment() {
    Get.toNamed(
      AppRoutes.paymentMethodScreen,
      arguments: selectedIndex.value,
    );
  }
}

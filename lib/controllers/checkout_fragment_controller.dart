import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/modals/payment_modal.dart';
import 'package:jify_app/navigation/routes.dart';

class CheckoutFragmentController extends GetxController {
  final mainController = Get.find<MainPageController>();
  final promoCodeController = TextEditingController();
  final cardNumberController = TextEditingController();

  void openDeliveryAddresses() {
    Get.toNamed(Routes.deliveryAddresses);
  }

  void openConfirmationPage() {
    Get.toNamed(Routes.confirmation);
  }

  void openPaymentModal() {
    Get.bottomSheet(PaymentModal());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/navigation/routes.dart';

class AccountInformationPageController extends GetxController {
  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final oldPassTextController = TextEditingController();
  final newPassTextController = TextEditingController();
  final confirmPassTextController = TextEditingController();

  void openDeliveryAddressesPage() {
    Get.toNamed(Routes.deliveryAddresses);
  }

  void openAddressesPage() {
    Get.toNamed(Routes.addresses);
  }

  @override
  void onClose() {
    nameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    mobileTextController.dispose();
    oldPassTextController.dispose();
    newPassTextController.dispose();
    confirmPassTextController.dispose();
    super.onClose();
  }
}

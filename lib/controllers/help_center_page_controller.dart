import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/modals/contact_us_modal.dart';
import 'package:jify_app/repositories/app_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class HelpCenterPageController extends GetxController {
  final _appRepository = AppRepository();
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final subjectTextController = TextEditingController();
  final orderNumberTextController = TextEditingController();
  final messagesTextController = TextEditingController();

  final _loadingStatus = false.obs;

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  void openContactUsModal() {
    Get.bottomSheet(ContactUsModal(),
            isScrollControlled: true, ignoreSafeArea: false)
        .then((value) => clearTextFields());
  }

  void clearTextFields() {
    fullNameTextController.clear();
    emailTextController.clear();
    subjectTextController.clear();
    orderNumberTextController.clear();
    messagesTextController.clear();
  }

  void closeModal() {
    Get.back();
  }

  void submitMessage() {
    loadingStatus = true;
    _appRepository
        .contactSupport(
            fullNameTextController.text,
            emailTextController.text,
            subjectTextController.text,
            orderNumberTextController.text,
            messagesTextController.text)
        .then((value) =>
            value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(String message) {
    loadingStatus = false;
    Utilities.makeCustomToast(message);
    Get.back();
  }
}

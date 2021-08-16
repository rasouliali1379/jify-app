import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/modals/contact_us_modal.dart';
import 'package:jify_app/repositories/app_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class HelpCenterPageController extends GetxController {
  final _globalController = Get.find<GlobalController>();
  final _appRepository = AppRepository();
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final subjectTextController = TextEditingController();
  final orderNumberTextController = TextEditingController();
  final messagesTextController = TextEditingController();

  final _fullNameError = "".obs;
  final _emailError = "".obs;
  final _subjectError = "".obs;
  final _messagesError = "".obs;

  final _loadingStatus = false.obs;

  @override
  void onInit() {
    fillDefaultData();
    super.onInit();
  }

  String get fullNameError => _fullNameError.value;

  set fullNameError(String value) {
    _fullNameError.value = value;
  }

  String get emailError => _emailError.value;

  set emailError(String value) {
    _emailError.value = value;
  }

  String get subjectError => _subjectError.value;

  set subjectError(String value) {
    _subjectError.value = value;
  }

  String get messagesError => _messagesError.value;

  set messagesError(String value) {
    _messagesError.value = value;
  }

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
    fullNameError = "";
    emailError = "";
    subjectError = "";
    messagesError = "";

    fillDefaultData();
  }

  void closeModal() {
    Get.back();
  }

  void submitMessage() {
    if (validateFields()) {
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
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    makeCustomToast(message);
  }

  void attemptSucceed(String message) {
    loadingStatus = false;
    makeCustomToast(message);
    Get.back();
    clearTextFields();
  }

  void fillDefaultData() {
    if (_globalController.initialDataModel.user != null) {
      final userData = _globalController.initialDataModel.user!;

      if (userData.firstname != null && userData.lastname != null) {
        fullNameTextController.text =
            '${userData.firstname!} ${userData.lastname!}';
        emailTextController.text = userData.email!;
      }
    }
  }

  bool validateFields() {
    if (fullNameTextController.text.isEmpty) {
      fullNameError = "You need to enter your full name";
      return false;
    }
    fullNameError = "";

    if (emailTextController.text.isEmpty) {
      emailError = "You need to enter your email";
      return false;
    }

    if (emailTextController.text.isEmail) {
      emailError = "You need to enter a valid email";
      return false;
    }

    emailError = "";

    if (subjectTextController.text.isEmpty) {
      subjectError = "You need to enter a subject";
      return false;
    }
    subjectError = "";

    if (messagesTextController.text.isEmpty) {
      messagesError = "Enter your message please";
      return false;
    }
    messagesError = "";

    return true;
  }
}

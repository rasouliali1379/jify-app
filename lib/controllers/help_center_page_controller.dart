import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/modals/contact_us_modal.dart';
import 'package:jify_app/repositories/app_repository.dart';
import 'package:jify_app/utilities/utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HelpCenterPageController extends GetxController {
  final _globalController = Get.find<GlobalController>();
  final _appRepository = AppRepository();
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final orderNumberTextController = TextEditingController();
  final messagesTextController = TextEditingController();

  final _fullNameError = "".obs;
  final _emailError = "".obs;
  final _messagesError = "".obs;
  final _selectedSubject = "".obs;

  final _loadingStatus = false.obs;

  @override
  void onInit() {
    fillDefaultData();
    super.onInit();
  }

  String get selectedSubject => _selectedSubject.value;

  set selectedSubject(String value) {
    _selectedSubject.value = value;
  }

  String get fullNameError => _fullNameError.value;

  set fullNameError(String value) {
    _fullNameError.value = value;
  }

  String get emailError => _emailError.value;

  set emailError(String value) {
    _emailError.value = value;
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
    showMaterialModalBottomSheet(
      context: Get.context!,
      builder: (context) => ContactUsModal(),
    ).then((value) => clearTextFields());
    // Get.bottomSheet(ContactUsModal(),
    //         isScrollControlled: true, ignoreSafeArea: false)
    //     .then((value) => clearTextFields());
  }

  void clearTextFields() {
    fullNameTextController.clear();
    emailTextController.clear();
    orderNumberTextController.clear();
    messagesTextController.clear();
    fullNameError = "";
    emailError = "";
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
          .contactSupport(fullNameTextController.text, emailTextController.text, selectedSubject,
              orderNumberTextController.text, messagesTextController.text)
          .then((value) => value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
    }
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
    Get.back();
    clearTextFields();
  }

  void fillDefaultData() {
    if (_globalController.initialDataModel.user != null) {
      final userData = _globalController.initialDataModel.user!;

      if (userData.firstname != null && userData.lastname != null) {
        fullNameTextController.text = '${userData.firstname!} ${userData.lastname!}';
        emailTextController.text = userData.email!;
      }
      if (Get.arguments != null) {
        orderNumberTextController.text = Get.arguments.toString();
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

    if (!emailTextController.text.isEmail) {
      emailError = "You need to enter a valid email";
      return false;
    }

    emailError = "";

    if (messagesTextController.text.isEmpty) {
      messagesError = "Enter your message please";
      return false;
    }
    messagesError = "";

    return true;
  }

  void onSubjectClickHandler(String subject) {
    selectedSubject = subject;
  }
}

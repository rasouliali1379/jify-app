import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/user_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class AccountInformationPageController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final _userRepository = UserRepository();

  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  // final oldPassTextController = TextEditingController();
  // final newPassTextController = TextEditingController();
  // final confirmPassTextController = TextEditingController();

  final _phoneNumber = "".obs;
  final _loadingStatus = false.obs;
  final _selectedAddress = "".obs;

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }

  String get selectedAddress => _selectedAddress.value;

  set selectedAddress(String value) {
    _selectedAddress.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  String get phoneNumber => _phoneNumber.value;

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  void openDeliveryAddressesPage() {
    Get.toNamed(Routes.deliveryAddresses);
  }

  void openAddressesPage() {
    Get.toNamed(Routes.addresses);
  }

  void getUserData() {
    final userInfo = globalController.initialDataModel.user;
    if (userInfo != null) {
      phoneNumber = userInfo.mobileNumber!;
      nameTextController.text = userInfo.firstname!;
      lastNameTextController.text = userInfo.lastname!;
      emailTextController.text = userInfo.email!;
    }
    checkSelectedAddress();
  }

  void checkSelectedAddress() {
    final userInfo = globalController.initialDataModel.user;
    if (userInfo!.addresses!.isNotEmpty) {
      if (storageExists(AppKeys.address)) {
        AddressModel? address = findAddress(
            userInfo.addresses!, storageRead(AppKeys.address) as String);

        if (address != null) {
          selectedAddress = address.address!;
        } else {
          storageRemove(AppKeys.address).then((value) => null);
        }
      } else {
        storageRemove(AppKeys.address).then((value) => null);
      }
    }
  }

  AddressModel? findAddress(List<AddressModel> addresses, String id) {
    for (final address in addresses) {
      if (address.id == id) {
        return address;
      }
    }

    return null;
  }

  void updateUserData() {
    loadingStatus = true;
    final userInfo = globalController.initialDataModel.user;
    userInfo!.firstname = nameTextController.text;
    userInfo.lastname = lastNameTextController.text;
    userInfo.email = emailTextController.text;

    _userRepository.updateUser(userInfo).then((value) =>
        value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    makeCustomToast(message);
  }

  void attemptSucceed(UserModel user) {
    loadingStatus = false;
    globalController.initialDataModel.user = user;
    makeCustomToast("You're information updated");
    Get.back();
  }

  @override
  void onClose() {
    nameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    // oldPassTextController.dispose();
    // newPassTextController.dispose();
    // confirmPassTextController.dispose();
    super.onClose();
  }
}

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
    Get.toNamed(Routes.deliveryAddresses)!
        .then((value) => checkSelectedAddress());
  }

  void openAddressesPage() {
    Get.toNamed(Routes.addresses,
            arguments: true, parameters: {"from": "account_information"})!
        .then((value) => checkSelectedAddress());
  }

  void getUserData() {
    final userInfo = globalController.initialDataModel.user;
    if (userInfo != null) {
      phoneNumber = userInfo.mobileNumber!;
      nameTextController.text =
          userInfo.firstname != null ? userInfo.firstname! : "";
      lastNameTextController.text =
          userInfo.lastname != null ? userInfo.lastname! : "";
      emailTextController.text = userInfo.email != null ? userInfo.email! : "";
    }
    checkSelectedAddress();
  }

  void checkSelectedAddress() {
    final userInfo = globalController.initialDataModel.user;
    if (userInfo!.addresses!.isNotEmpty) {
      if (storageExists(AppKeys.address)) {
        final AddressModel? address = findAddress(
            userInfo.addresses!, storageRead(AppKeys.address) as String);

        if (address != null) {
          selectedAddress = address.address!;
        } else {
          storageWrite(AppKeys.address, userInfo.addresses!.last.id);
          selectedAddress = userInfo.addresses!.last.id!;
        }
      } else {
        storageWrite(AppKeys.address, userInfo.addresses!.last.id);
        selectedAddress = userInfo.addresses!.last.id!;
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
    showCustomSnackBar(message);
  }

  void attemptSucceed(UserModel user) {
    loadingStatus = false;
    globalController.initialDataModel.user = user;
    showCustomSnackBar("You're information updated");
    Get.back();
  }

  @override
  void onClose() {
    nameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    super.onClose();
  }
}

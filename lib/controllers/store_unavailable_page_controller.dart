import 'package:get/get.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class StoreUnavailablePageController extends GetxController {
  final _loadingStatus = false.obs;

  late AddressModel _address;

  @override
  void onInit() {
    _address = Get.arguments as AddressModel;
    super.onInit();
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  final _addressRepository = AddressRepository();

  void notifyCustomer() {
    loadingStatus = true;
    _addressRepository
        .notifyAddress(_address.id!)
        .then((result) => result.fold((l) => attemptFailed(l), (r) => attemptSucceed(status: r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed({required bool status}) {
    loadingStatus = false;

    if (status) {
      showCustomSnackBar("We will notify you");
      Get.back();
    } else {
      showCustomSnackBar("Something Unexpected happened");
    }
  }
}

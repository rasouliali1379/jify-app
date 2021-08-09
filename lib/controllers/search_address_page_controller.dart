import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/models/address_prediction_model.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class SearchAddressPageController extends GetxController {
  final _addressRepository = AddressRepository();
  final searchTextController = TextEditingController();
  final searchFocus = FocusNode();

  final _loadingStatus = false.obs;
  final _predictedAddresses = <AddressPredictionModel>[].obs;

  @override
  void onReady() {
    searchFocus.requestFocus();

    super.onReady();
  }

  List<AddressPredictionModel> get predictedAddresses => _predictedAddresses;

  set predictedAddresses(List<AddressPredictionModel> value) {
    _predictedAddresses.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  void onSearchQueryChangeHandler(String query) {
    if (query.length % 3 == 0) {
      loadingStatus = true;
      _addressRepository.predictAddress(query).then((value) =>
          value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
    }
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(List<AddressPredictionModel> addresses) {
    loadingStatus = false;
    predictedAddresses = addresses;
  }

  void onPredictionCLickHandler(String id) {
    _addressRepository
        .getLatLong(id)
        .then((value) => value.fold((l) => attemptFailed(l), (r) {
              Get.back(result: r);
            }));
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/location_model.dart';
import 'package:jify_app/models/predicted_lat_long_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class DeliveryAddressesPageController extends GetxController {
  final mapCompleter = Completer<GoogleMapController>();
  final _addressRepository = AddressRepository();

  final floorTextController = TextEditingController();
  final buildingTextController = TextEditingController();
  final noteTextController = TextEditingController();
  final _selectedTag = 0.obs;

  final _selectedOption = 0.obs;
  final _selectedAddress = PredictedLatLongModel().obs;
  final _loadingStatus = false.obs;

  final _cameraPosition = const CameraPosition(
    target: LatLng(-35.282001, 149.128998),
    zoom: 14.4746,
  ).obs;

  late GoogleMapController mapController;

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  CameraPosition get cameraPosition => _cameraPosition.value;

  set cameraPosition(CameraPosition value) {
    _cameraPosition.value = value;
  }

  PredictedLatLongModel get selectedAddress => _selectedAddress.value;

  set selectedAddress(PredictedLatLongModel value) {
    _selectedAddress.value = value;
  }

  int get selectedOption => _selectedOption.value;

  set selectedOption(int value) {
    _selectedOption.value = value;
  }

  int get selectedTag => _selectedTag.value;

  set selectedTag(int value) {
    _selectedTag.value = value;
  }

  Function() onTagClickHandler(int index) {
    return () {
      selectedTag = index;
    };
  }

  Function() onOptionClickHandler(int index) {
    return () {
      selectedOption = index;
    };
  }

  void openSearchAddress() {
    Get.toNamed(Routes.searchAddress)!
        .then((value) => selectAddress(value as PredictedLatLongModel));
  }

  void selectAddress(PredictedLatLongModel model) {
    selectedAddress = model;

    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(selectedAddress.geometry!.location!.lat!,
          selectedAddress.geometry!.location!.lng!),
      zoom: 14.4746,
    )));
  }

  void onMapCreated(GoogleMapController controller) {
    mapCompleter.complete(controller);
    mapController = controller;
  }

  void addAddress() {
    if (selectedAddress.name != null) {
      final addressModel = AddressModel(
        type: getTag(selectedTag),
        address: selectedAddress.name,
        location: LocationModel(coordinates: [
          selectedAddress.geometry!.location!.lat,
          selectedAddress.geometry!.location!.lng,
        ]),
        options: getOption(selectedOption),
        apt: floorTextController.text,
        building: buildingTextController.text,
        note: noteTextController.text,
      );
      if (!storageExists(AppKeys.token) &&
          !storageExists(AppKeys.unsavedAddress)) {
        storageWrite(AppKeys.unsavedAddress, json.encode(addressModel.toJson()))
            .then((value) => Get.close(2));
      } else {
        loadingStatus = true;
        _addressRepository.addAddress(addressModel).then((value) =>
            value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
      }
    } else {
      Utilities.makeCustomToast('You need to enter your address');
    }
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(List<AddressModel> addresses) {
    loadingStatus = false;
    Get.find<GlobalController>().initialDataModel.user!.addresses = addresses;
    storageWrite(AppKeys.address, addresses.last.id).then((value) {
      Get.back();
    });
  }

  String getTag(int index) {
    String tag = "Custom";

    switch (index) {
      case 0:
        tag = "Home";
        break;
      case 1:
        tag = "Office";
        break;
      case 2:
        tag = "Custom";
        break;
    }
    return tag;
  }

  String getOption(int index) {
    String option = "Meet outside";

    switch (index) {
      case 0:
        option = "Leave at door";
        break;
      case 1:
        option = "Meet at door";
        break;
    }
    return option;
  }
}

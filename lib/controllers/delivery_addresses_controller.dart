import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/modals/custom_alert_dialog.dart';
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
  final _selectedAddress = AddressModel().obs;
  final _loadingStatus = false.obs;
  final _deletionLoading = false.obs;

  final _cameraPosition = const CameraPosition(
    target: LatLng(-35.282001, 149.128998),
    zoom: 14.4746,
  ).obs;

  late GoogleMapController mapController;

  bool get loadingStatus => _loadingStatus.value;

  bool editMode = false;

  String? from;

  @override
  void onInit() {
    defineMode();
    super.onInit();
  }

  bool get deletionLoading => _deletionLoading.value;

  set deletionLoading(bool value) {
    _deletionLoading.value = value;
  }

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  CameraPosition get cameraPosition => _cameraPosition.value;

  set cameraPosition(CameraPosition value) {
    _cameraPosition.value = value;
  }

  AddressModel get selectedAddress => _selectedAddress.value;

  set selectedAddress(AddressModel value) {
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

  void defineMode() {
    if (Get.arguments != null) {
      if (Get.arguments is AddressModel) {
        selectedAddress = Get.arguments as AddressModel;
        editMode = true;
      }
    }
    final params = Get.parameters;
    if (params.containsKey("from")) {
      from = params["from"];
    }
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
    final newAddress = AddressModel(
        id: selectedAddress.id,
        address: model.formattedAddress,
        location: LocationModel(coordinates: [
          model.geometry!.location!.lat!,
          model.geometry!.location!.lng!
        ]),
        options: selectedAddress.options,
        note: selectedAddress.note,
        building: selectedAddress.building,
        apt: selectedAddress.apt,
        type: selectedAddress.type,
        distance: selectedAddress.distance);

    selectedAddress = newAddress;

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
          model.geometry!.location!.lat!, model.geometry!.location!.lng!),
      zoom: 14.4746,
    )));
  }

  void onMapCreated(GoogleMapController controller) {
    mapCompleter.complete(controller);
    mapController = controller;
    fillData();
  }

  void addAddress() {
    if (selectedAddress.address != null) {
      final addressModel = AddressModel(
        type: getTag(selectedTag),
        address: selectedAddress.address,
        location: LocationModel(coordinates: [
          selectedAddress.location!.coordinates![0],
          selectedAddress.location!.coordinates![1]
        ]),
        options: getOption(selectedOption),
        apt: floorTextController.text,
        building: buildingTextController.text,
        note: noteTextController.text,
      );
      if (!storageExists(AppKeys.token) &&
          !storageExists(AppKeys.unsavedAddress)) {
        final globalController = Get.find<GlobalController>();
        final storeLocation = LatLng(
          globalController.initialDataModel.storeLocation![0],
          globalController.initialDataModel.storeLocation![1],
        );
        final distance = _addressRepository.calculateDistance(
            LatLng(selectedAddress.location!.coordinates![0] as double,
                selectedAddress.location!.coordinates![1] as double),
            storeLocation);
        final availableDistance =
            globalController.initialDataModel.supportedDistance;

        globalController.isAddressInRange = distance <= availableDistance!;

        storageWrite(AppKeys.unsavedAddress, json.encode(addressModel.toJson()))
            .then((value) {
          if (globalController.isAddAddressModalOpen) {
            globalController.isAddAddressModalOpen = false;
            Get.close(2);
          } else {
            Get.back();
          }
          // Get.find<CheckoutFragmentController>().checkSelectedAddress();
          if (!globalController.isAddressInRange && !editMode) {
            Get.toNamed(Routes.storeUnavailable, arguments: addressModel);
          }
        });
      } else {
        loadingStatus = true;
        if (editMode) {
          _addressRepository
              .updateAddress(selectedAddress.id!, addressModel)
              .then((value) => value.fold(
                  (l) => attemptFailed(l), (r) => attemptSucceed(r)));
        } else {
          _addressRepository.addAddress(addressModel).then((value) =>
              value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
        }
      }
    } else {
      showCustomSnackBar('You need to enter your address');
    }
  }

  void confirmDeletion() {
    Get.bottomSheet(
      CustomAlertDialog(
          "Delete Address",
          "Are you sure about deleting this delivery address?",
          "Yes",
          "No",
          deleteAddress,
          () => Get.back()),
      enableDrag: false,
    );
  }

  void deleteAddress() {
    Get.back();
    deletionLoading = true;
    _addressRepository.deleteAddress(selectedAddress.id!).then((value) =>
        value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    deletionLoading = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed(List<AddressModel> addresses) {
    loadingStatus = false;
    deletionLoading = false;
    final globalController = Get.find<GlobalController>();

    if (addresses.isEmpty) {
      final _mainController = Get.find<MainPageController>();
      _mainController.onBottomNavClickHandler(0);
      globalController.isAddressInRange = true;
      if (from != null) {
        switch (from) {
          case "account_information":
            Get.close(3);
            break;
          case "checkout":
            Get.close(2);
            break;
        }
      }
      _mainController.openDeliveryAddressModal();
      return;
    }

    globalController.initialDataModel.user!.addresses = addresses;
    if (editMode) {
      final address =
          _addressRepository.findAddress(addresses, selectedAddress.id!);
      globalController.isAddressInRange = address.distance! <=
          globalController.initialDataModel.supportedDistance!;
    } else {
      storageWrite(AppKeys.address, addresses.last.id).then((value) {
        globalController.isAddressInRange = addresses.last.distance! <=
            globalController.initialDataModel.supportedDistance!;
      });
    }
    // Get.find<CheckoutFragmentController>().checkSelectedAddress();
    if (globalController.isAddAddressModalOpen) {
      globalController.isAddAddressModalOpen = false;
      Get.close(2);
    } else {
      Get.back();
    }
    if (!globalController.isAddressInRange && !editMode) {
      Get.toNamed(Routes.storeUnavailable, arguments: addresses.last);
    }
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
        tag = "Gym";
        break;
    }
    return tag;
  }

  int getTagIndex(String tag) {
    int index = 3;

    switch (tag.toLowerCase()) {
      case "home":
        index = 0;
        break;
      case "office":
        index = 1;
        break;
      case "gym":
        index = 2;
        break;
    }
    return index;
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

  int getOptionIndex(String option) {
    int index = 2;

    switch (option) {
      case "Leave at door":
        index = 0;
        break;
      case "Meet at door":
        index = 1;
        break;
    }
    return index;
  }

  void fillData() {
    if (editMode) {
      selectedTag = getTagIndex(selectedAddress.type!);
      selectedOption = getOptionIndex(selectedAddress.options!);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(selectedAddress.location!.coordinates![0] as double,
            selectedAddress.location!.coordinates![1] as double),
        zoom: 14.4746,
      )));
      floorTextController.text = selectedAddress.apt!;
      buildingTextController.text = selectedAddress.building!;
      noteTextController.text = selectedAddress.note!;
    }
  }
}

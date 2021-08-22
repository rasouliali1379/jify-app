import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/checkout_model.dart';
import 'package:jify_app/models/delivery_model.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/models/payment_model.dart';
import 'package:jify_app/models/promotion_code_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/repositories/checkout_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class ConfirmationPageController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final mapCompleter = Completer<GoogleMapController>();
  final noteTextController = TextEditingController();
  final checkoutRepository = CheckoutRepository();
  final _addressRepository = AddressRepository();

  final _selectedOption = 0.obs;
  // final _selectedSchedule = "".obs;
  final _loadingStatus = false.obs;
  final _selectedAddress = AddressModel().obs;

  final cameraPosition = const CameraPosition(
    target: LatLng(-35.282001, 149.128998),
    zoom: 14.4746,
  );

  late GoogleMapController mapController;
  final _checkoutData = CheckoutModel().obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  AddressModel get selectedAddress => _selectedAddress.value;

  set selectedAddress(AddressModel value) {
    _selectedAddress.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  // String get selectedSchedule => _selectedSchedule.value;
  //
  // set selectedSchedule(String value) {
  //   _selectedSchedule.value = value;
  // }

  CheckoutModel get checkoutData => _checkoutData.value;

  set checkoutData(CheckoutModel value) {
    _checkoutData.value = value;
  }

  int get selectedOption => _selectedOption.value;

  set selectedOption(int value) {
    _selectedOption.value = value;
  }

  // void openSchedule() {
  //   Get.toNamed(Routes.schedule, preventDuplicates: true)!
  //       .then((value) => selectedSchedule = value as String);
  // }

  Function() onOptionClickHandler(int index) {
    return () {
      selectedOption = index;
    };
  }

  void onMapCreated(GoogleMapController controller) {
    mapCompleter.complete(controller);
    mapController = controller;
  }

  void getData() {
    checkoutData = Get.arguments as CheckoutModel;
    checkSelectedAddress();
  }

  void checkSelectedAddress() {
    selectedAddress = _addressRepository.findAddress(
        globalController.initialDataModel.user!.addresses!,
        storageRead(AppKeys.address) as String);
    selectedOption = getOptionIndex(selectedAddress.options!);
    noteTextController.text = selectedAddress.note!;
    mapCompleter.future.then((value) =>
        value.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(selectedAddress.location!.coordinates![0] as double,
              selectedAddress.location!.coordinates![1] as double),
          zoom: 14.4746,
        ))));
  }

  String getDeliveryAddress(String address) {
    if (address!.length > 30) {
      return '${address.substring(0, 30)}...';
    }
    return address;
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

  // void onStandardScheduleClickHandler() {
  //   selectedSchedule = "";
  // }

  void placeOrder() {
    loadingStatus = true;
    checkoutRepository
        .completeCheckout(
            checkoutData.checkout!.id!,
            DeliveryModel(
              note: noteTextController.text,
              options: getOption(selectedOption),
              // time: selectedSchedule
            ),
            PaymentModel(code: "asdasdfriwqejrioqwuer8932ur98432uc9823uj49"))
        .then((value) =>
            value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    makeCustomToast(message);
  }

  void attemptSucceed(OrderModel promo) {
    loadingStatus = false;
    globalController.basket.clear();
    final checkoutController = Get.find<CheckoutFragmentController>();
    checkoutController.populateOrders();
    checkoutController.promoCode = PromotionCodeModel();
    Get.find<MainPageController>().onBottomNavClickHandler(2);
    Get.find<OrdersFragmentController>().getOrderList();
    Get.find<GlobalController>().updateTotalCost();
    Get.find<HomeFragmentController>().update();
    Get.back();
    makeCustomToast("Order submitted");
  }

  void openAddressesPage() {
    Get.toNamed(Routes.addresses)?.then((value) => checkSelectedAddress());
  }
}

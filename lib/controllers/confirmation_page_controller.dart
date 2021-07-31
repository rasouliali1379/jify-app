import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/navigation/routes.dart';

class ConfirmationPageController extends GetxController {
  final mapController = Completer<GoogleMapController>();

  final noteTextController = TextEditingController();

  final _selectedOption = 0.obs;

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  int get selectedOption => _selectedOption.value;

  set selectedOption(int value) {
    _selectedOption.value = value;
  }

  void openSchedule() {
    Get.toNamed(Routes.schedule);
  }

  Function() onOptionClickHandler(int index) {
    return () {
      selectedOption = index;
    };
  }
}

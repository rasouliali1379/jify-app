import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryAddressesPageController extends GetxController {
  final mapController = Completer<GoogleMapController>();

  final floorTextController = TextEditingController();
  final noteTextController = TextEditingController();
  final _selectedTag = 0.obs;

  final _selectedOption = 0.obs;

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/addresses_page_controller.dart';
import 'package:jify_app/widgets/address_item.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';

class AddressesPage extends GetView<AddressesPageController> {
  @override
  Widget build(BuildContext context) {
    final addresses = [
      AddressItem(
          'North Terrace',
          'SW3 2BA London',
          controller.selectedAddress == 0,
          () => controller.onAddressClickHandler(0),
          controller.getIcon('home')),
      AddressItem('North Terrace', 'SW3 2BA London',
          controller.selectedAddress == 1,
          () => controller.onAddressClickHandler(1), controller.getIcon('gym')),
      AddressItem(
          'North Terrace',
          'SW3 2BA London',
          controller.selectedAddress == 2,
          () => controller.onAddressClickHandler(2),
          controller.getIcon('office')),
      AddressItem(
          'North Terrace',
          'SW3 2BA London',
          controller.selectedAddress == 3,
          () => controller.onAddressClickHandler(3),
          controller.getIcon('custom')),
    ];
    return Scaffold(
      appBar: CustomToolBar('My Addresses',
          action: const Text(
            'Edit',
            style: AppTextStyles.white16Normal400,
          )),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => addresses[index],
      ),
    );
  }
}

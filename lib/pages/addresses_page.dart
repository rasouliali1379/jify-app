import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/addresses_page_controller.dart';
import 'package:jify_app/widgets/address_item.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';

class AddressesPage extends GetView<AddressesPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar('My Addresses',
          action: const Text(
            'Edit',
            style: AppTextStyles.white16Normal400,
          )),
      body: ListView.builder(
        itemCount: controller.addressList.length,
        itemBuilder: (context, index) => AddressItem(
            controller.addressList[index],
            controller.addressList[index].id == controller.selectedAddress,
            controller.onAddressClickHandler,
            controller.getIcon(controller.addressList[index].type!)),
      ),
    );
  }
}

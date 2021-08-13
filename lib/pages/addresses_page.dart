import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/addresses_page_controller.dart';
import 'package:jify_app/widgets/address_item.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';

class AddressesPage extends GetView<AddressesPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white
    ));
    return Scaffold(
      appBar: CustomToolBar('My Addresses',
          action: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Obx(
              () => ClickableText(
                controller.editMode ? 'Done' : 'Edit',
                controller.toggleEditMode,
                style: AppTextStyles.white16Normal400,
              ),
            ),
          )),
      body: Stack(
        children: [
          GetBuilder<AddressesPageController>(
            builder: (controller) => ListView.builder(
              itemCount: controller.addressList.length,
              padding: EdgeInsets.only(bottom: Get.height * 0.1),
              itemBuilder: (context, index) => AddressItem(
                controller.addressList[index],
                controller.onAddressClickHandler,
                controller.getIcon(controller.addressList[index].type!),
                controller.editAddresses,
                selected: controller.addressList[index].id ==
                    controller.selectedAddress,
                editMode: controller.editMode,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.0369, vertical: Get.height * 0.03),
              child: LongButton(
                controller.openDeliveryAddressPage,
                'Add Address',
                double.maxFinite,
                Get.height * 0.064,
              ),
            ),
          )
        ],
      ),
    );
  }
}

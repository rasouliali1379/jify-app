import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/delivery_addresses_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/location_tag_item.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class DeliveryAddressesPage extends GetView<DeliveryAddressesPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Delivery Addresses'),
      backgroundColor: AppColors.milky,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: Get.height * 0.1613,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: controller.cameraPosition,
                    rotateGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    tiltGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    onMapCreated: controller.onMapCreated,
                  ),
                  Align(
                    child: SvgPicture.asset(
                      'assets/icons/location.svg',
                      color: AppColors.red,
                      height: 24,
                      width: 24,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.0233,
                  ),
                  const Text(
                    'Location Tag',
                    style: AppTextStyles.extraDarkCyan16Normal500,
                  ),
                  SizedBox(
                    height: Get.height * 0.0233,
                  ),
                  Obx(() => Row(
                        children: [
                          LocationTagItem('assets/icons/home.svg', 'Home',
                              controller.onTagClickHandler(0),
                              selected: controller.selectedTag == 0),
                          SizedBox(
                            width: Get.width * 0.0266,
                          ),
                          LocationTagItem('assets/icons/briefcase.svg',
                              'Office', controller.onTagClickHandler(1),
                              selected: controller.selectedTag == 1),
                          SizedBox(
                            width: Get.width * 0.0266,
                          ),
                          LocationTagItem('assets/icons/dumbells.svg', 'Gym',
                              controller.onTagClickHandler(2),
                              selected: controller.selectedTag == 2),
                          SizedBox(
                            width: Get.width * 0.0266,
                          ),
                          LocationTagItem('assets/icons/location.svg', 'Custom',
                              controller.onTagClickHandler(3),
                              selected: controller.selectedTag == 3),
                        ],
                      )),
                  SizedBox(
                    height: Get.height * 0.0406,
                  ),
                  const Text(
                    'Delivery Address',
                    style: AppTextStyles.extraDarkCyan16Normal500,
                  ),
                  SizedBox(
                    height: Get.height * 0.0233,
                  ),
                  const Text(
                    'Address',
                    style: AppTextStyles.darkGrey13Normal300,
                  ),
                  SizedBox(
                    height: Get.height * 0.00985,
                  ),
                  Obx(() => GestureDetector(
                        onTap: controller.openSearchAddress,
                        child: Container(
                          width: double.maxFinite,
                          height: Get.height * 0.0591,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/icons/location_tall.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  controller.selectedAddress.name ??
                                      'Search for location',
                                  style: controller.selectedAddress.name == null
                                      ? AppTextStyles.lightGrey14Normal300
                                      : AppTextStyles.darkGrey14Normal300,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: Get.height * 0.0233,
                  ),
                  TitledTextField('Apt / Suite / Floor (optional) ',
                      controller.floorTextController,
                      textFieldBgColor: AppColors.white),
                  SizedBox(
                    height: Get.height * 0.0233,
                  ),
                  TitledTextField(
                    'Building / business name (optional)',
                    controller.floorTextController,
                    textFieldBgColor: AppColors.white,
                  ),
                  SizedBox(
                    height: Get.height * 0.0307,
                  ),
                  const Text(
                    'Delivery Options',
                    style: AppTextStyles.extraDarkCyan16Normal500,
                  ),
                  SizedBox(
                    height: Get.height * 0.027,
                  ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.onOptionClickHandler(0),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 0
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
                                        borderRadius: BorderRadius.circular(9)),
                                child: Text(
                                  'Leave at door',
                                  style: controller.selectedOption == 0
                                      ? AppTextStyles.blue13Normal300
                                      : AppTextStyles.darkGrey13Normal400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.0186,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.onOptionClickHandler(1),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 1
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
                                        borderRadius: BorderRadius.circular(9)),
                                child: Text(
                                  'Meet at door',
                                  style: controller.selectedOption == 1
                                      ? AppTextStyles.blue13Normal300
                                      : AppTextStyles.darkGrey13Normal400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.0186,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.onOptionClickHandler(2),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 2
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
                                        borderRadius: BorderRadius.circular(9)),
                                child: Text(
                                  'Meet outside',
                                  style: controller.selectedOption == 2
                                      ? AppTextStyles.blue13Normal300
                                      : AppTextStyles.darkGrey13Normal400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: Get.height * 0.0381,
                  ),
                  TitledTextField(
                    'Delivery Notes (optional)',
                    controller.noteTextController,
                    textFieldBgColor: AppColors.white,
                  ),
                  SizedBox(
                    height: Get.height * 0.0357,
                  ),
                  Obx(() => LongButton(
                        controller.addAddress,
                        'Save',
                        double.maxFinite,
                        Get.height * 0.064,
                        customText: controller.loadingStatus
                            ? const SpinKitThreeBounce(
                                color: AppColors.white,
                                size: 15,
                              )
                            : null,
                      )),
                  SizedBox(
                    height: Get.height * 0.0418,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/long_button.dart';

class ChooseDeliveryAddressModal extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.2672,
        padding: EdgeInsets.only(
            top: 10,
            left: Get.width * 0.0453,
            right: Get.width * 0.0453,
            bottom: Get.height * 0.0221),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Choose your Delivery Address',
                        style: AppTextStyles.black16Normal500,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Delivery time and availability varies for different locations',
                        style: AppTextStyles.grey14Normal400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                LongButton(
                    () => Navigator.of(context)
                        .pushNamed(Routes.deliveryAddresses),
                    'Add New Address',
                    Get.width,
                    Get.height * 0.064),
                SizedBox(
                  height: Get.height * 0.0172,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.signInVisibility,
                    child: ClickableText(
                      "or sign in instead",
                      controller.openSignInPage,
                      style: AppTextStyles.blue12Normal400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

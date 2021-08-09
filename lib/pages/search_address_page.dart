import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/search_address_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/predicted_address_item.dart';

class SearchAddressPage extends GetView<SearchAddressPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Delivery Addresses'),
      backgroundColor: AppColors.milky,
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.0307,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0373),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColors.grey),
                color: AppColors.white),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchTextController,
                    focusNode: controller.searchFocus,
                    cursorHeight: 20,
                    cursorColor: AppColors.blue,
                    onChanged: controller.onSearchQueryChangeHandler,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: AppTextStyles.lightGrey14Normal300,
                        hintText: "Search here"),
                  ),
                ),
                Obx(() => controller.loadingStatus
                    ? const SpinKitRing(
                        color: AppColors.blue,
                        size: 20,
                        lineWidth: 2,
                      )
                    : const SizedBox())
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.0197,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              color: Color.fromRGBO(226, 226, 226, 1),
              height: 0,
              thickness: 1.5,
            ),
          ),
          Obx(() => Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.0295),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.168),
                  child: const Divider(
                    color: AppColors.grey,
                    thickness: 1.5,
                    height: 0,
                  ),
                ),
                itemBuilder: (context, index) => PredictedAddressItem(
                    controller.predictedAddresses[index],
                    controller.onPredictionCLickHandler),
                itemCount: controller.predictedAddresses.length,
              )))
        ],
      ),
    );
  }
}

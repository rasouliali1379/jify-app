import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/widgets/long_button.dart';

class StoreClosedModal extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: Get.height * 0.3879,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0506),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    Center(
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.grey),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.009,
                    ),
                    Container(
                      width: Get.width * 0.128,
                      height: Get.width * 0.128,
                      padding: EdgeInsets.all(Get.width * 0.0293),
                      decoration: const BoxDecoration(
                        color: AppColors.milky,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset('assets/icons/door.svg'),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'Closed Store',
                      style: AppTextStyles.red16Normal500
                          .copyWith(color: const Color.fromRGBO(193, 5, 5, 1)),
                    ),
                    SizedBox(
                      height: Get.height * 0.016,
                    ),
                    const Text(
                      'Thank you but at the moment our store is closed.'
                      ' please return later.',
                      style: AppTextStyles.grey14Normal400,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Get.height * 0.02,
                ),
                child: LongButton(() => Get.back(), 'Ok Got it', Get.width,
                    Get.height * 0.064),
              )
            ]));
  }
}

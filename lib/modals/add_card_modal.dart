import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class AddCardModal extends GetView<ConfirmationPageController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Get.height * 0.447,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.048, vertical: Get.height * 0.0233),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add New Card',
                      style: AppTextStyles.black16Normal600,
                    ),
                    CircleButton(
                      const Icon(
                        Icons.clear,
                        size: 20,
                      ),
                      AppColors.grey,
                      () => Get.back(),
                      width: Get.width * 0.0746,
                      height: Get.width * 0.0746,
                    )
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 1,
                decoration: const BoxDecoration(color: AppColors.milky),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.0233, horizontal: Get.width * 0.0453),
                child: Column(
                  children: [
                    TitledTextField(
                      'Card Number',
                      controller.cardNumberController,
                      titleStyle: AppTextStyles.extraDarkCyan14Normal400,
                      customTextField: Container(
                        padding: const EdgeInsets.only(right: 10),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(11), color: AppColors.semiLightBlue),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: controller.cardNumberController,
                                onChanged: controller.cardNumberChangeHandler,
                                focusNode: controller.cardNumberFocus,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [CreditCardNumberInputFormatter()],
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10, bottom: 11, top: 11, right: 10),
                                    hintStyle: AppTextStyles.extraLightBlue16Normal300,
                                    hintText: "**** **** **** ****"),
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset('assets/images/discover.png',
                                    width: Get.width * 0.0853, height: Get.height * 0.027),
                                SizedBox(
                                  width: Get.width * 0.013,
                                ),
                                Image.asset('assets/images/master_card.png',
                                    width: Get.width * 0.0853, height: Get.height * 0.027),
                                SizedBox(
                                  width: Get.width * 0.013,
                                ),
                                Image.asset('assets/images/visa.png',
                                    width: Get.width * 0.0853, height: Get.height * 0.027),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.0283,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TitledTextField(
                            'Expiry date',
                            controller.expireDateController,
                            titleStyle: AppTextStyles.extraDarkCyan14Normal400,
                            customTextField: Container(
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11), color: AppColors.semiLightBlue),
                              child: TextField(
                                controller: controller.expireDateController,
                                focusNode: controller.expireDateFocus,
                                onChanged: controller.expireDateChangeHandler,
                                inputFormatters: [CreditCardExpirationDateFormatter()],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10, bottom: 11, top: 11, right: 10),
                                    hintStyle: AppTextStyles.extraLightBlue16Normal300,
                                    hintText: "MM/YY"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.0506,
                        ),
                        Expanded(
                          child: TitledTextField(
                            'CVC/CVV',
                            controller.cvcNumberController,
                            titleStyle: AppTextStyles.extraDarkCyan14Normal400,
                            customTextField: Container(
                              padding: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11), color: AppColors.semiLightBlue),
                              child: TextField(
                                controller: controller.cvcNumberController,
                                focusNode: controller.cvcNumberFocus,
                                onChanged: controller.cvcNumberChangeHandler,
                                inputFormatters: [CreditCardCvcInputFormatter()],
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10, bottom: 11, top: 11, right: 10),
                                    hintStyle: AppTextStyles.extraLightBlue16Normal300,
                                    hintText: "3 digits"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.02, left: Get.width * 0.0453, right: Get.width * 0.0453),
            child: Obx(() => LongButton(
                  controller.addNewCard,
                  'Add Card',
                  Get.width,
                  Get.height * 0.064,
                  customText: controller.loadingStatus
                      ? const SpinKitThreeBounce(
                          size: 15,
                          color: AppColors.white,
                        )
                      : null,
                )),
          )
        ],
      ),
    );
  }
}

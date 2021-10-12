import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/enums/payment_enum.dart';
import 'package:jify_app/widgets/payment_method_item.dart';

class PaymentMethodModal extends GetView<ConfirmationPageController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Get.height * 0.454,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.grey),
            ),
          ),
          SizedBox(
            height: Get.height * 0.009,
          ),
          const Text(
            'Payment',
            style: AppTextStyles.extraDarkCyan16Normal500,
          ),
          SizedBox(
            height: Get.height * 0.009,
          ),
          Text(
            'Select payment method',
            style: TextStyle(color: AppColors.black.withOpacity(0.6), fontWeight: FontWeight.w400, fontSize: 14),
          ),
          SizedBox(
            height: Get.height * 0.065,
          ),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (Platform.isIOS) ...[
                  PaymentMethodItem(
                    payment: Payment.apple,
                    onClick: controller.onPaymentMethodClickHandler,
                    selected: controller.paymentMethod.name == Payment.apple.name,
                  ),
                  SizedBox(
                    height: Get.height * 0.019,
                  ),
                ],
                if (Platform.isAndroid) ...[
                  PaymentMethodItem(
                    payment: Payment.google,
                    onClick: controller.onPaymentMethodClickHandler,
                    selected: controller.paymentMethod.name == Payment.google.name,
                  ),
                  SizedBox(
                    height: Get.height * 0.019,
                  )
                ],
                if (Get.find<GlobalController>().initialDataModel.user!.card != null)
                  PaymentMethodItem(
                    payment: Payment.card,
                    onClick: controller.onPaymentMethodClickHandler,
                    selected: controller.paymentMethod.name == Payment.card.name,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

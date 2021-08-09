import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/order_info_controller.dart';
import 'package:jify_app/widgets/custom_tile.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/dashed_divider.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/order_info_orders_list_item.dart';

class OrderInfoPage extends GetView<OrderInfoPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(
        'Order Info',
        action: const Text(
          'Help',
          style: AppTextStyles.white16Normal400,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.032, horizontal: Get.width * 0.0453),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order status',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Obx(
                        () => Text(
                          controller.orderDetail.status!,
                          style: AppTextStyles.green14Normal300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.0197,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order number',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Obx(
                        () => Text(
                          controller.orderDetail.orderNumber!.toString(),
                          style: AppTextStyles.darkGrey14Normal300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.0197,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Obx(
                        () => Text(
                          controller
                              .getFormattedDate(controller.orderDetail.date!),
                          style: AppTextStyles.darkGrey14Normal300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.0344,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.milky,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.032,
                        horizontal: Get.width * 0.0453),
                    child: Column(
                      children: [
                        Obx(
                          () => CustomTile(
                              'assets/icons/location.svg',
                              'Address delivered',
                              controller.orderDetail.address!.address!),
                        ),
                        SizedBox(
                          height: Get.height * 0.0283,
                        ),
                        const CustomTile('assets/icons/credit_card.svg',
                            'Payment method', 'Visa Card'),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.032,
                        horizontal: Get.width * 0.0453),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Items',
                            style: AppTextStyles.extraDarkCyan16Normal500),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.027),
                          separatorBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.0184),
                            height: 1,
                            color: AppColors.grey,
                          ),
                          itemCount: controller.orderDetail.products!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              OrderInfoOrdersListItem(
                                  controller.orderDetail.products![index]),
                        ),
                        SizedBox(
                          height: Get.height * 0.0172,
                        ),
                        const Text(
                          'Summary',
                          style: AppTextStyles.extraDarkCyan16Normal500,
                        ),
                        SizedBox(
                          height: Get.height * 0.0332,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                'Subtotal (${controller.orderDetail.products!.length} items)',
                                style: AppTextStyles.darkGrey14Normal300,
                              ),
                            ),
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                    text: '\$',
                                    style: AppTextStyles.green13Normal400,
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .orderDetail.amount!.subTotal!
                                            .toString(),
                                        style: AppTextStyles.green15Normal400,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.0197,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery',
                              style: AppTextStyles.darkGrey14Normal300,
                            ),
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                    text: '\$',
                                    style: AppTextStyles.green13Normal400,
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .orderDetail.amount!.delivery!
                                            .toString(),
                                        style: AppTextStyles.green15Normal400,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.0197,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Promo code',
                              style: AppTextStyles.darkGrey14Normal300,
                            ),
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                    text: '- \$',
                                    style: AppTextStyles.red13Normal400,
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .orderDetail.amount!.promotion!
                                            .toString(),
                                        style: AppTextStyles.red15Normal400,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.0258,
                        ),
                        DashedDivider(
                          height: 1,
                          color: AppColors.darkGrey.withOpacity(0.2),
                        ),
                        SizedBox(
                          height: Get.height * 0.0258,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: AppTextStyles.darkGrey14Normal300,
                            ),
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                    text: '\$',
                                    style: AppTextStyles.green13Normal400,
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .orderDetail.amount!.total!
                                            .toString(),
                                        style: AppTextStyles.green15Normal400,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.0381,
                        ),
                        Obx(
                          () => controller.orderDetail.status == "unknown"
                              ? const SizedBox()
                              : LongButton(controller.reorder, 'Re-order',
                                  double.maxFinite, Get.height * 0.064),
                        ),
                        SizedBox(
                          height: Get.height * 0.0381,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

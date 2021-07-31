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
  final items = [
    const OrderInfoOrdersListItem(
        'assets/images/pomegranate.png', 'Pomegranate', '5', '48.00'),
    const OrderInfoOrdersListItem(
        'assets/images/lemons.png', 'Lemon', '5', '48.00')
  ];

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
                    children: const [
                      Text(
                        'Order status',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Text(
                        'Completed',
                        style: AppTextStyles.green14Normal300,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.0197,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Order number',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Text(
                        '141554647',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.0197,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Date',
                        style: AppTextStyles.darkGrey14Normal300,
                      ),
                      Text(
                        'September19 , 2021 - 22:45',
                        style: AppTextStyles.darkGrey14Normal300,
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
                        const CustomTile('assets/icons/location.svg',
                            'Address delivered', 'London , Johnson ST , 46548'),
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
                          itemCount: items.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => items[index],
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
                            const Text(
                              'Subtotal (3 items)',
                              style: AppTextStyles.darkGrey14Normal300,
                            ),
                            RichText(
                              text: const TextSpan(
                                  text: '\$',
                                  style: AppTextStyles.green13Normal400,
                                  children: [
                                    TextSpan(
                                      text: '48.00',
                                      style: AppTextStyles.green15Normal400,
                                    )
                                  ]),
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
                            RichText(
                              text: const TextSpan(
                                  text: '\$',
                                  style: AppTextStyles.green13Normal400,
                                  children: [
                                    TextSpan(
                                      text: '48.00',
                                      style: AppTextStyles.green15Normal400,
                                    )
                                  ]),
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
                            RichText(
                              text: const TextSpan(
                                  text: '- \$',
                                  style: AppTextStyles.red13Normal400,
                                  children: [
                                    TextSpan(
                                      text: '48.00',
                                      style: AppTextStyles.red15Normal400,
                                    )
                                  ]),
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
                            RichText(
                              text: const TextSpan(
                                  text: '\$',
                                  style: AppTextStyles.green13Normal400,
                                  children: [
                                    TextSpan(
                                      text: '48.00',
                                      style: AppTextStyles.green15Normal400,
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.0381,
                        ),
                        LongButton(() => {}, 'Re-order', double.maxFinite,
                            Get.height * 0.064),
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

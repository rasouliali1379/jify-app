import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/widgets/checkout_orders_list_item.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/dashed_divider.dart';
import 'package:jify_app/widgets/long_button.dart';

class CheckoutFragment extends StatefulWidget {
  @override
  _CheckoutFragmentState createState() => _CheckoutFragmentState();
}

class _CheckoutFragmentState extends State<CheckoutFragment>
    with AutomaticKeepAliveClientMixin {
  final _controller = Get.find<CheckoutFragmentController>();

  @override
  bool get wantKeepAlive => true;

  final items = [
    CheckoutOrdersListItem('Pomegranate', '48.00', 6,
        'assets/images/pomegranate.png', () => {}, () => {}),
    CheckoutOrdersListItem(
        'Lemon', '48.00', 6, 'assets/images/lemons.png', () => {}, () => {}),
    CheckoutOrdersListItem(
        'Kiwi', '48.00', 6, 'assets/images/kiwi.png', () => {}, () => {})
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomToolBar(
        'Checkout',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.032, horizontal: Get.width * 0.0453),
              separatorBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: Get.height * 0.0184),
                height: 1,
                color: AppColors.grey,
              ),
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => items[index],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Promo Code',
                          style: AppTextStyles.extraDarkCyan16Normal500,
                        ),
                        SizedBox(
                          height: Get.height * 0.0221,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.003,
                              horizontal: Get.width * 0.0426),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: AppColors.white),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: AppTextStyles.darkGrey13Normal300
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.2)),
                                    hintText: "Enter your promo code..."),
                                controller: _controller.promoCodeController,
                              )),
                              CircleButton(
                                const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 15,
                                ),
                                AppColors.green,
                                () => {},
                                width: Get.width * 0.0533,
                                height: Get.width * 0.0533,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.0369,
                        ),
                        const Text(
                          'Delivery Addresses',
                          style: AppTextStyles.extraDarkCyan16Normal500,
                        ),
                        SizedBox(
                          height: Get.height * 0.0221,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.013,
                              horizontal: Get.width * 0.0426),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: AppColors.white),
                          child: Row(
                            children: [
                              const Expanded(
                                  child: Text(
                                'NY - Daniel ST , 147552',
                                style: AppTextStyles.darkGrey13Normal300,
                              )),
                              ClickableText(
                                  'Edit', _controller.openDeliveryAddresses)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.0369,
                        ),
                        const Text(
                          'Payment',
                          style: AppTextStyles.extraDarkCyan16Normal500,
                        ),
                        SizedBox(
                          height: Get.height * 0.0221,
                        ),
                        GestureDetector(
                          onTap: _controller.openPaymentModal,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.013,
                                horizontal: Get.width * 0.0426),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: AppColors.white),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/apple_logo.svg',
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.024,
                                    ),
                                    const Text(
                                      'Apple Pay',
                                      style: AppTextStyles.darkGrey13Normal300,
                                    ),
                                  ],
                                )),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.grayishBlack,
                                )
                              ],
                            ),
                          ),
                        ),
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
                        LongButton(_controller.openConfirmationPage, 'Checkout',
                            double.maxFinite, Get.height * 0.064),
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

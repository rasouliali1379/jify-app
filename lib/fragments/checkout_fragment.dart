import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/widgets/checkout_orders_list_item.dart';
import 'package:jify_app/widgets/circle_button.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomToolBar('Checkout', backButtonVisibility: false),
        body: Obx(
          () => _controller.orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/customer.svg',
                        width: Get.width * 0.04346,
                        height: Get.height * 0.2795,
                      ),
                      SizedBox(
                        height: Get.height * 0.0369,
                      ),
                      const Text(
                        'Your basket is empty',
                        style: AppTextStyles.extraDarkCyan24Normal700,
                      ),
                      SizedBox(
                        height: Get.height * 0.0369,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.1413),
                        child: Text(
                          'Items will appear here after you have added them',
                          style: AppTextStyles.extraDarkCyan16Normal500
                              .copyWith(
                                  color: AppTextColors.extraDarkCyan
                                      .withOpacity(0.6)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.0394,
                      ),
                      LongButton(
                        _controller.startShopping,
                        "Shop Now",
                        Get.width * 0.33,
                        Get.height * 0.0566,
                        color: AppColors.blue,
                        elevation: 0,
                        labelColor: AppColors.white,
                        borderRadius: 50,
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.032,
                                horizontal: Get.width * 0.0453),
                            separatorBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.0184),
                              height: 1,
                              color: AppColors.grey,
                            ),
                            itemCount: _controller.orders.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                CheckoutOrdersListItem(
                                    _controller.orders[index].qty!,
                                    _controller.findProduct(
                                        _controller.orders[index].id!)!,
                                    _controller.increaseAmount,
                                    _controller.decreaseAmount),
                          )),
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
                                    style:
                                        AppTextStyles.extraDarkCyan16Normal500,
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
                                    child: Obx(
                                      () => _controller.promoCode.code != null
                                          ? Row(
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: Text(
                                                    _controller.promoCode.code!,
                                                    style: AppTextStyles
                                                        .darkGrey15Normal400
                                                        .copyWith(
                                                            color: AppColors
                                                                .darkGrey),
                                                  ),
                                                )),
                                                CircleButton(
                                                  const Icon(
                                                    Icons.remove,
                                                    color: AppColors.white,
                                                    size: 15,
                                                  ),
                                                  AppColors.red,
                                                  _controller.removePromoCode,
                                                  width: Get.width * 0.0533,
                                                  height: Get.width * 0.0533,
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                    child: TextField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      hintStyle: AppTextStyles
                                                          .darkGrey13Normal300
                                                          .copyWith(
                                                              color: AppColors
                                                                  .darkGrey
                                                                  .withOpacity(
                                                                      0.2)),
                                                      hintText:
                                                          "Enter your promo code..."),
                                                  controller: _controller
                                                      .promoCodeController,
                                                  focusNode:
                                                      _controller.promoFocus,
                                                )),
                                                if (_controller
                                                    .promoLoadingStatus)
                                                  const SpinKitThreeBounce(
                                                    color: AppColors.green,
                                                    size: 15,
                                                  )
                                                else
                                                  CircleButton(
                                                    const Icon(
                                                      Icons.add,
                                                      color: AppColors.white,
                                                      size: 15,
                                                    ),
                                                    AppColors.green,
                                                    _controller.checkPromoCode,
                                                    width: Get.width * 0.0533,
                                                    height: Get.width * 0.0533,
                                                  )
                                              ],
                                            ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: Get.height * 0.0369,
                                  // ),
                                  // const Text(
                                  //   'Delivery Addresses',
                                  //   style:
                                  //       AppTextStyles.extraDarkCyan16Normal500,
                                  // ),
                                  // SizedBox(
                                  //   height: Get.height * 0.0221,
                                  // ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: Get.height * 0.013,
                                  //       horizontal: Get.width * 0.0426),
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(11),
                                  //       color: AppColors.white),
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //           child: Obx(() => Text(
                                  //                 _controller.selectedAddress
                                  //                             .address !=
                                  //                         null
                                  //                     ? _controller
                                  //                         .selectedAddress
                                  //                         .address!
                                  //                     : 'No address defined',
                                  //                 style: AppTextStyles
                                  //                     .darkGrey13Normal300,
                                  //                 maxLines: 1,
                                  //                 overflow:
                                  //                     TextOverflow.ellipsis,
                                  //               ))),
                                  //       ClickableText(
                                  //           'Change', _controller.openAddresses)
                                  //     ],
                                  //   ),
                                  // ),
                                  // // SizedBox(
                                  //   height: Get.height * 0.0369,
                                  // ),
                                  // const Text(
                                  //   'Payment',
                                  //   style:
                                  //       AppTextStyles.extraDarkCyan16Normal500,
                                  // ),
                                  // SizedBox(
                                  //   height: Get.height * 0.0221,
                                  // ),
                                  // GestureDetector(
                                  //   onTap: _controller.openPaymentModal,
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(
                                  //         vertical: Get.height * 0.013,
                                  //         horizontal: Get.width * 0.0426),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(11),
                                  //         color: AppColors.white),
                                  //     child: Row(
                                  //       children: [
                                  //         Expanded(
                                  //             child: Row(
                                  //           children: [
                                  //             SvgPicture.asset(
                                  //               'assets/icons/apple_logo.svg',
                                  //               width: 16,
                                  //               height: 16,
                                  //             ),
                                  //             SizedBox(
                                  //               width: Get.width * 0.024,
                                  //             ),
                                  //             const Text(
                                  //               'Apple Pay',
                                  //               style: AppTextStyles
                                  //                   .darkGrey13Normal300,
                                  //             ),
                                  //           ],
                                  //         )),
                                  //         const Icon(
                                  //           Icons.keyboard_arrow_down_rounded,
                                  //           color: AppColors.grayishBlack,
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
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
                                    style:
                                        AppTextStyles.extraDarkCyan16Normal500,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0332,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => Text(
                                            'Subtotal (${_controller.orders.length} items)',
                                            style: AppTextStyles
                                                .darkGrey14Normal300,
                                          )),
                                      Obx(
                                        () => RichText(
                                          text: TextSpan(
                                              text: '\$',
                                              style: AppTextStyles
                                                  .green13Normal400,
                                              children: [
                                                TextSpan(
                                                  text: _controller
                                                      .subtotalPrice
                                                      .toStringAsFixed(2),
                                                  style: AppTextStyles
                                                      .green15Normal400,
                                                )
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0197,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Delivery',
                                        style:
                                            AppTextStyles.darkGrey14Normal300,
                                      ),
                                      Obx(() => RichText(
                                            text: TextSpan(
                                                text: '\$',
                                                style: AppTextStyles
                                                    .green13Normal400,
                                                children: [
                                                  TextSpan(
                                                    text: _controller
                                                        .deliveryPrice
                                                        .toStringAsFixed(2),
                                                    style: AppTextStyles
                                                        .green15Normal400,
                                                  )
                                                ]),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0197,
                                  ),
                                  if (_controller.promoCode.value != null)
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Promo code',
                                              style: AppTextStyles
                                                  .darkGrey14Normal300,
                                            ),
                                            Obx(() => RichText(
                                                  text: TextSpan(
                                                      text: '- \$',
                                                      style: AppTextStyles
                                                          .red13Normal400,
                                                      children: [
                                                        TextSpan(
                                                          text: _controller
                                                              .promoCodePrice
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: AppTextStyles
                                                              .red15Normal400,
                                                        )
                                                      ]),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.0258,
                                        ),
                                      ],
                                    ),
                                  DashedDivider(
                                    height: 1,
                                    color: AppColors.darkGrey.withOpacity(0.2),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0258,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total',
                                        style:
                                            AppTextStyles.darkGrey14Normal300,
                                      ),
                                      Obx(() => RichText(
                                            text: TextSpan(
                                                text: '\$',
                                                style: AppTextStyles
                                                    .green13Normal400,
                                                children: [
                                                  TextSpan(
                                                    text: _controller.totalPrice
                                                        .toStringAsFixed(2),
                                                    style: AppTextStyles
                                                        .green15Normal400,
                                                  )
                                                ]),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.0381,
                                  ),
                                  Obx(() => LongButton(
                                        _controller.checkout,
                                        'Checkout',
                                        double.maxFinite,
                                        Get.height * 0.064,
                                        customText: _controller.loadingStatus
                                            ? const SpinKitThreeBounce(
                                                size: 15,
                                                color: AppColors.white,
                                              )
                                            : null,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}

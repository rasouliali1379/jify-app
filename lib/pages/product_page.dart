import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/product_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';

class ProductPage extends GetView<ProductPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar(controller.product.title!,
          action: InkWell(
            onTap: controller.openBasket,
            child: Obx(() => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0506),
                  child: Badge(
                    badgeContent: Text(
                      controller.variants.toString(),
                      style: AppTextStyles.white12Normal400,
                    ),
                    padding: const EdgeInsets.all(6),
                    borderSide: const BorderSide(
                      color: AppColors.white,
                    ),
                    badgeColor: AppColors.lightGreen,
                    position: BadgePosition.topStart(
                        top: Get.height * -0.0184, start: Get.width * 0.0213),
                    toAnimate: false,
                    child: SvgPicture.asset(
                      'assets/icons/shop_basket.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                )),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AspectRatio(
                  aspectRatio: 1.25,
                  child:
                      CachedNetworkImage(imageUrl: controller.product.image!),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.product.title!,
                          style: AppTextStyles.black21Normal500,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0,
                      ),
                      if (controller.product.off! > 0)
                        Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.112,
                              height: Get.width * 0.112,
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/discount.svg",
                                    width: Get.width * 0.112,
                                    height: Get.width * 0.112,
                                  ),
                                  Center(
                                    child: Text(
                                      controller.product.off! > 0
                                          ? "-${controller.product.off!.toStringAsFixed(0)}%"
                                          : "",
                                      style: AppTextStyles.white12Normal700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (controller.product.off! > 0)
                              SizedBox(
                                height: Get.height * 0.007,
                              ),
                            if (controller.product.off! > 0)
                              RichText(
                                text: TextSpan(
                                    text: ' \$ ',
                                    style: AppTextStyles.green16Normal600,
                                    children: [
                                      TextSpan(
                                          text: controller.product.offPrice!
                                              .toStringAsFixed(2),
                                          style: AppTextStyles.green20Normal600)
                                    ]),
                              ),
                            if (controller.product.off! > 0)
                              SizedBox(
                                height: Get.height * 0.007,
                              ),
                            if (controller.product.off! > 0)
                              Text("\$ ${controller.product.price!.toString()}",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(161, 161, 161, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough)),
                            SizedBox(
                              width: Get.width * 0.024,
                            ),
                          ],
                        ),
                      if (controller.product.off! == 0)
                        RichText(
                          text: TextSpan(
                              text: ' \$ ',
                              style: AppTextStyles.green16Normal600,
                              children: [
                                TextSpan(
                                    text: controller.product.price!
                                        .toStringAsFixed(2),
                                    style: AppTextStyles.green20Normal600)
                              ]),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.0246,
                ),
                const Divider(
                  height: 0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: Get.height * 0.13,
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: Text(
                        controller.product.description!,
                        style: AppTextStyles.grayishBlack12Normal300
                            .copyWith(height: 1.6),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                SizedBox(
                  height: Get.height * 0.0246,
                ),
                Center(
                  child: Container(
                    width: Get.width * 0.381,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color.fromRGBO(225, 225, 225, 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: controller.decreaseCount,
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(Get.height * 0.012),
                              child: const Icon(
                                Icons.remove,
                                color: Color.fromRGBO(188, 188, 188, 1),
                              ),
                            )),
                        Obx(
                          () => Text(
                            controller.count.toString(),
                            style: AppTextStyles.black18Normal600,
                          ),
                        ),
                        InkWell(
                            onTap: controller.increaseCount,
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(Get.height * 0.012),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.blue,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.0246,
                ),
                const Divider(
                  height: 0,
                ),
                // SizedBox(
                //   height: Get.height * 0.0394,
                // ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(bottom: Get.height * 0.03),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.0266,
                  vertical: Get.height * 0.0209),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${controller.count} Added to basket',
                      style: AppTextStyles.white18Normal500,
                    ),
                    if (controller.product.off! > 0)
                      Text(
                        '\$${(controller.count * controller.product.offPrice!).toStringAsFixed(2)}',
                        style: AppTextStyles.white18Normal500,
                      )
                    else
                      Text(
                        '\$${(controller.count * controller.product.price!).toStringAsFixed(2)}',
                        style: AppTextStyles.white18Normal500,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

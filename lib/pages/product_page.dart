import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/product_page_controller.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';

class ProductPage extends GetView<ProductPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar(controller.product.title!,
          action: InkWell(
            onTap: controller.openBasket,
            child: Obx(() => Badge(
                  badgeContent: Text(
                    controller.variants.toString(),
                    style: AppTextStyles.white12Normal400,
                  ),
                  padding: const EdgeInsets.all(6),
                  borderSide: const BorderSide(
                    color: AppColors.white,
                  ),
                  badgeColor: AppColors.lightGreen,
                  position: BadgePosition.topStart(top: -17, start: 6),
                  toAnimate: false,
                  child: SvgPicture.asset(
                    'assets/icons/shop_basket.svg',
                    width: 24,
                    height: 24,
                  ),
                )),
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child:
                        CachedNetworkImage(imageUrl: controller.product.image!),
                  ),
                  Text(
                    controller.product.title!,
                    style: AppTextStyles.black21Normal500,
                  ),
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleButton(
                                const Icon(
                                  Icons.remove,
                                  color: AppColors.white,
                                ),
                                AppColors.grey,
                                controller.decreaseCount),
                            Obx(() => Text(
                                  controller.count.toString(),
                                  style: AppTextStyles.darkGrey17Normal300,
                                )),
                            CircleButton(
                                const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                                AppColors.blue,
                                controller.increaseCount),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            text: ' \$ ',
                            style: AppTextStyles.green16Normal600,
                            children: [
                              TextSpan(
                                  text: (controller.count *
                                          controller.product.price!)
                                      .toString(),
                                  style: AppTextStyles.green20Normal600)
                            ]),
                      ),
                    ],
                  ),
                  Divider(
                    height: Get.height * 0.07,
                  ),
                  Text(
                    controller.product.description!,
                    style: AppTextStyles.grayishBlack12Normal300
                        .copyWith(height: 1.6),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.0453, vertical: 30),
                child: LongButton(controller.addToBasket, 'Add to Basket',
                    double.maxFinite, Get.height * 0.064),
              ))
        ],
      ),
    );
  }
}

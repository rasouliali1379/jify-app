import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: CustomToolBar(
        'Heineken Beer',
        action: Badge(
          badgeContent: const Text(
            '1',
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
        ),
      ),
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
                    child: Image.asset('assets/images/beer.png'),
                  ),
                  Text(
                    'Heineken Beer',
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
                        text: const TextSpan(
                            text: ' \$ ',
                            style: AppTextStyles.green16Normal600,
                            children: [
                              TextSpan(
                                  text: '2.46',
                                  style: AppTextStyles.green20Normal600)
                            ]),
                      ),
                    ],
                  ),
                  Divider(
                    height: Get.height * 0.07,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet,'
                    ' consectetur adipiscing elit,'
                    ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                    ' Ut enim ad minim veniam,'
                    ' quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                    ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
                child: LongButton(() => {}, 'Add to Basket', double.maxFinite,
                    Get.height * 0.064),
              ))
        ],
      ),
    );
  }
}

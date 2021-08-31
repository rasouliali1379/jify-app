import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/store_unavailable_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';

class StoreUnavailablePage extends GetView<StoreUnavailablePageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar(
        'Store Unavailable',
        action: Padding(
          padding: EdgeInsets.only(right: Get.width * 0.04),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.width * 0.0453),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.116,
              child: Stack(
                children: [
                  Positioned(
                    left: Get.width * 0.03,
                    right: 0,
                    child: SvgPicture.asset(
                      "assets/icons/sad_face.svg",
                      width: Get.width * 0.16,
                      height: Get.width * 0.16,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/box.png",
                      width: Get.width * 0.3146,
                      height: Get.height * 0.0652,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.0406,
            ),
            const Text(
              "Currently Unavailable",
              style: AppTextStyles.red22Normal700,
            ),
            SizedBox(
              height: Get.height * 0.0246,
            ),
            Text(
              "Sorry, we don't yet deliver to your address, but we are expanding fast!",
              style: AppTextStyles.white16Normal400
                  .copyWith(color: const Color.fromRGBO(98, 73, 73, 1)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Get.height * 0.0517,
            ),
            Obx(
              () => LongButton(
                controller.notifyCustomer,
                '',
                Get.width,
                Get.height * 0.064,
                customText: controller.loadingStatus
                    ? const SpinKitThreeBounce(
                        color: AppColors.white,
                        size: 15,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/bell.svg"),
                          SizedBox(
                            width: Get.width * 0.024,
                          ),
                          const Text(
                            "Notify Me When Available",
                            style: AppTextStyles.white18Normal400,
                          )
                        ],
                      ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.0233,
            ),
            ClickableText(
              "Back to Home",
              () => Get.back(),
              style: AppTextStyles.blue17Normal400,
            )
          ],
        ),
      ),
    );
  }
}

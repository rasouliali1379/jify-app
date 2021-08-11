import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/widgets/custom_bottom_nav_item.dart';

class CustomBottomNav extends StatelessWidget {
  final int index;
  final Function onClick;

  const CustomBottomNav(this.index, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1.2,
          height: 0,
          color: AppColors.semiLightBlue,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * 0.0906,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBottomNavItem(
                      'assets/icons/home.svg', () => onClick(0), index == 0),
                  CustomBottomNavItem(
                      'assets/icons/profile.svg', () => onClick(1), index == 1),
                  CustomBottomNavItem(
                      'assets/icons/note.svg', () => onClick(2), index == 2),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * 0.1,
            ),
            GestureDetector(
              onTap: () => onClick(3),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/shop_basket.svg'),
                    const SizedBox(
                      width: 8,
                    ),
                    GetX<GlobalController>(builder: (controller) {
                      return Text(
                        controller.totalCost.toStringAsFixed(2),
                        style: AppTextStyles.white14Normal700,
                      );
                    })
                  ],
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.0906,
            )
          ],
        ),
      ],
    );
  }
}

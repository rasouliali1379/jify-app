import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/widgets/long_button.dart';

class IntroSliderItem extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String btnLabel;
  final GestureTapCallback onClick;

  const IntroSliderItem(this.image, this.title, this.desc, this.btnLabel, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: 15,
                  top: 45,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(-25 / 360),
                    child: Container(
                      width: Get.width * 2,
                      height: Get.height * 0.2672,
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(200)),
                    ),
                  ),
                ),
                Image.asset(image),
              ],
            ),
            Text(
              title,
              style: AppTextStyles.white26Normal600,
            ),
            SizedBox(
              height: Get.width * 0.0307,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                desc,
                style: AppTextStyles.white14Normal300.copyWith(height: 1.25),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
          child: LongButton(
            onClick,
            btnLabel,
            double.maxFinite,
            Get.height * 0.064,
            color: AppColors.white,
            labelColor: AppColors.blue,
          ),
        ),
        SizedBox(
          height: Get.width * 0.0258,
        ),
      ],
    );
  }
}

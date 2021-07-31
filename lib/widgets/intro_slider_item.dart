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
  final CustomPainter painter;

  const IntroSliderItem(this.image, this.title, this.desc, this.btnLabel,
      this.onClick, this.painter);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomPaint(
              painter: painter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0826),
                child: Image.asset(image),
              ),
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

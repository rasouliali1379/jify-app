import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class IntroSliderItem extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const IntroSliderItem(this.image, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0826),
          child: Image.asset(image),
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
    );
  }
}

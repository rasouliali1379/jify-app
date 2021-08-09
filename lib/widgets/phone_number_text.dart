import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class PhoneNumberText extends StatelessWidget {
  final String text;

  const PhoneNumberText(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mobile number',
          style: AppTextStyles.darkGrey13Normal300,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: Get.height * 0.0591,
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0373),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(11)),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/australia.svg',
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: Get.width * 0.0266,
              ),
              const Text(
                '+61',
                style: AppTextStyles.darkGrey13Normal300,
              ),
              SizedBox(
                width: Get.width * 0.0346,
              ),
              const VerticalDivider(
                color: AppColors.grey,
                thickness: 1,
                width: 0,
              ),
              SizedBox(
                width: Get.width * 0.0453,
              ),
              Expanded(child: Text(text, style: AppTextStyles.grey14Normal300))
            ],
          ),
        ),
      ],
    );
  }
}

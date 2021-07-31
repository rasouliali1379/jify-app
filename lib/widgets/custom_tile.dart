import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CustomTile extends StatelessWidget {
  final String icon;
  final String head;
  final String content;

  const CustomTile(this.icon, this.head, this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.width * 0.112,
          height: Get.width * 0.112,
          padding: EdgeInsets.symmetric(
              vertical: Get.width * 0.03, horizontal: Get.width * 0.03),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.white),
          child: SvgPicture.asset(
            icon,
            color: AppColors.blue,
          ),
        ),
        SizedBox(
          width: Get.width * 0.0293,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head,
              style: AppTextStyles.grayishBlack11Normal300,
            ),
            SizedBox(
              height: Get.height * 0.006,
            ),
            Text(
              content,
              style: AppTextStyles.darkGrey14Normal400,
            )
          ],
        ))
      ],
    );
  }
}

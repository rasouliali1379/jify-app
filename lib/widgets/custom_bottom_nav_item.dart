import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';

class CustomBottomNavItem extends StatelessWidget {
  final String image;
  final GestureTapCallback onClick;
  final bool selected;

  const CustomBottomNavItem(this.image, this.onClick, this.selected);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onClick,
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                image,
                color: selected ? AppColors.blue : AppColors.lightGrey,
                width: Get.width * 0.0586,
                height: Get.width * 0.0586,
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class AddressItem extends StatelessWidget {
  final String address1;
  final String address2;
  final bool selected;
  final GestureTapCallback onClick;
  final String icon;

  const AddressItem(
      this.address1, this.address2, this.selected, this.onClick, this.icon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.0612,
        margin: EdgeInsets.symmetric(
            vertical: Get.height * 0.0123, horizontal: Get.width * 0.0453),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue.withOpacity(0.15),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    color: AppColors.blue,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.0373,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      address1,
                      style: AppTextStyles.extraDarkCyan16Normal500
                          .copyWith(color: AppTextColors.darkCyan),
                    ),
                    SizedBox(
                      height: Get.height * 0.011,
                    ),
                    Text(
                      address2,
                      style: AppTextStyles.extraLightBlue14Normal300,
                    )
                  ],
                )
              ],
            ),
            Visibility(
              visible: selected,
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.blue),
                width: 22,
                height: 22,
                child: Container(
                  margin: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue,
                      border: Border.all(color: AppColors.white, width: 3)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

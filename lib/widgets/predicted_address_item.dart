import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/address_prediction_model.dart';

class PredictedAddressItem extends StatelessWidget {
  final AddressPredictionModel model;
  final Function onClick;

  const PredictedAddressItem(this.model, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(model.placeId),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: Get.height * 0.0172),
        child: Row(
          children: [
            Container(
                height: Get.width * 0.0853,
                width: Get.width * 0.0853,
                padding: EdgeInsets.all(Get.width * 0.016),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                child: SvgPicture.asset(
                  'assets/icons/location_tall.svg',
                  color: AppColors.darkGrey,
                )),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0533),
                child: Text(
                  model.description!,
                  style: AppTextStyles.black13Normal300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

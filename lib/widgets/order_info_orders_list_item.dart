import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class OrderInfoOrdersListItem extends StatelessWidget {
  final String image;
  final String name;
  final String amount;
  final String price;

  const OrderInfoOrdersListItem(this.image, this.name, this.amount, this.price);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.1226,
      height: Get.width * 0.1226,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      image,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.0373,
                ),
                Text(
                  name,
                  style: AppTextStyles.extraDarkCyan15Normal400,
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              'x$amount',
              style: AppTextStyles.darkGrey15Normal400,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                    text: '\$',
                    style: AppTextStyles.green13Normal400,
                    children: [
                      TextSpan(
                        text: price,
                        style: AppTextStyles.green15Normal400,
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

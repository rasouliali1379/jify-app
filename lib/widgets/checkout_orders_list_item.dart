import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/widgets/circle_button.dart';

class CheckoutOrdersListItem extends StatelessWidget {
  final String name;
  final String price;
  final int amount;
  final String image;
  final GestureTapCallback increaseHandler;
  final GestureTapCallback decreaseHandler;

  const CheckoutOrdersListItem(this.name, this.price, this.amount, this.image,
      this.increaseHandler, this.decreaseHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: Get.width * 0.16,
                height: Get.width * 0.16,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name - ${amount.toString()}kg',
                    style: AppTextStyles.extraDarkCyan15Normal400,
                  ),
                  SizedBox(
                    height: Get.height * 0.016,
                  ),
                  Row(
                    children: [
                      CircleButton(
                        const Icon(
                          Icons.remove,
                          color: AppColors.white,
                          size: 18,
                        ),
                        AppColors.darkGrey,
                        decreaseHandler,
                        width: Get.width * 0.0533,
                        height: Get.width * 0.0533,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          amount.toString(),
                          style: AppTextStyles.darkGrey17Normal300,
                        ),
                      ),
                      CircleButton(
                        const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 18,
                        ),
                        AppColors.darkGrey,
                        increaseHandler,
                        width: Get.width * 0.0533,
                        height: Get.width * 0.0533,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
              text: '\$',
              style: AppTextStyles.green13Normal400,
              children: [
                TextSpan(
                  text: price,
                  style: AppTextStyles.green15Normal400,
                )
              ]),
        )
      ],
    );
  }
}

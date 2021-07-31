import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class PreviousOrdersListItem extends StatelessWidget {
  final String orderId;
  final String price;
  final GestureTapCallback onClick;

  const PreviousOrdersListItem(this.orderId, this.price, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.04),
      margin: EdgeInsets.symmetric(vertical: Get.width * 0.011),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(11)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: AppTextStyles.extraDarkCyan14Normal400,
              ),
              RichText(
                  text: TextSpan(
                      text: ' \$ ',
                      style: AppTextStyles.green12Normal400,
                      children: [
                    TextSpan(text: price, style: AppTextStyles.green14Normal400)
                  ]))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100, height: 32, child: fruitsGroup()),
              Row(
                children: [
                  GestureDetector(
                    onTap: onClick,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.blue.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14)),
                      child: const Text(
                        'View',
                        style: AppTextStyles.blue13Normal400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(14)),
                    child: const Text(
                      'Re-order',
                      style: AppTextStyles.white13Normal400,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget fruitsGroup() {
    return Stack(
      children: [
        Positioned(
          left: 0,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGrey,
                border: Border.all(color: AppColors.white)),
            child: Image.asset(
              'assets/images/kiwi.png',
              height: 30,
              width: 30,
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGrey,
                border: Border.all(color: AppColors.white)),
            child: Image.asset(
              'assets/images/pomegranate.png',
              height: 30,
              width: 30,
            ),
          ),
        ),
        Positioned(
          left: 38,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGrey,
                border: Border.all(color: AppColors.white)),
            child: Image.asset(
              'assets/images/lemons.png',
              height: 30,
              width: 30,
            ),
          ),
        )
      ],
    );
  }
}

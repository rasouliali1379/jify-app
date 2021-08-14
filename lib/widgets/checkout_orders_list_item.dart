import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/widgets/circle_button.dart';

class CheckoutOrdersListItem extends StatelessWidget {
  final int amount;
  final ProductModel product;
  final Function increaseHandler;
  final Function decreaseHandler;

  const CheckoutOrdersListItem(
      this.amount, this.product, this.increaseHandler, this.decreaseHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Get.width * 0.16,
          height: Get.width * 0.16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey)),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.image!,
              ),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.0373,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      product.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.extraDarkCyan15Normal400,
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
                                text: product.off! > 0
                                    ? product.offPrice!.toStringAsFixed(2)
                                    : product.price!.toStringAsFixed(2),
                                style: AppTextStyles.green15Normal400,
                              )
                            ]),
                      ),
                    ),
                  )
                ],
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
                    () => decreaseHandler(product.id),
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
                    () => increaseHandler(product),
                    width: Get.width * 0.0533,
                    height: Get.width * 0.0533,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

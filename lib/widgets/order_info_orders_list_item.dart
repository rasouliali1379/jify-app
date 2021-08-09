import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/product_model.dart';

class OrderInfoOrdersListItem extends StatelessWidget {
  final ProductModel product;

  const OrderInfoOrdersListItem(this.product);

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
                Flexible(
                  child: Text(
                    product.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.extraDarkCyan15Normal400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Expanded(
            child: Text(
              'x${product.qty!}',
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
                        text: product.price!.toString(),
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

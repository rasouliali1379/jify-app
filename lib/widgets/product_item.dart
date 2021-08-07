import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/widgets/add_button.dart';
import 'package:jify_app/widgets/circle_button.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final Function addToBasket;
  final Function removeFromBasket;
  final Function onProductClickHandler;
  final int count;

  const ProductItem(this.product, this.addToBasket, this.removeFromBasket,
      this.onProductClickHandler, this.count);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onProductClickHandler(product),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: AspectRatio(
          aspectRatio: (Get.width * 0.293) / (Get.height * 0.2512),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: AppColors.extraLightBLue, width: 1.2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 4,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CachedNetworkImage(imageUrl: product.image!)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.title!,
                  style: AppTextStyles.darkPurple13Normal300,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  product.price.toString(),
                  style: AppTextStyles.darkPurple13Normal700,
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Get.height * 0.0369,
                      child: Builder(builder: (context) {
                        return count > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleButton(
                                    SizedBox(
                                        width: Get.width * 0.08,
                                        height: Get.width * 0.08,
                                        child: const Icon(
                                          Icons.remove,
                                          color: AppColors.green,
                                          size: 20,
                                        )),
                                    const Color.fromRGBO(200, 255, 216, 1),
                                    () => removeFromBasket(product.id),
                                    border: Border.all(
                                        color: AppColors.green, width: 2),
                                  ),
                                  Text(
                                    count.toString(),
                                    style:
                                        AppTextStyles.extraDarkCyan15Normal400,
                                  ),
                                  CircleButton(
                                      SizedBox(
                                          width: Get.width * 0.08,
                                          height: Get.width * 0.08,
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColors.white,
                                            size: 20,
                                          )),
                                      AppColors.green,
                                      () => addToBasket(product)),
                                ],
                              )
                            : AddButton(() => addToBasket(product));
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

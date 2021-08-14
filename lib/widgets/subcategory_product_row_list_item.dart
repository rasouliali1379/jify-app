import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/widgets/product_item.dart';

class SubcategoryProductRowList extends StatelessWidget {
  final CategoryModel category;
  final Function showAllOnClick;
  final Function addToBasket;
  final Function removeFromBasket;
  final Function onProductClickHandler;
  final Function countInBasket;
  final Function calculateDiscount;
  final int index;

  const SubcategoryProductRowList(
      this.category,
      this.showAllOnClick,
      this.addToBasket,
      this.removeFromBasket,
      this.onProductClickHandler,
      this.countInBasket,
      this.calculateDiscount,
      this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.title!,
                style: AppTextStyles.extraDarkCyan19Normal500,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () => showAllOnClick(index),
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: const [
                        Text(
                          'Show all',
                          style: AppTextStyles.blue14Normal500,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.blue,
                          size: 20,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.3078,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.029),
            scrollDirection: Axis.horizontal,
            itemCount: category.products!.length,
            itemBuilder: (context, index) => ProductItem(
              category.products![index],
              addToBasket,
              removeFromBasket,
              onProductClickHandler,
              countInBasket(category.products![index].id!) as int,
              discountedPrice: category.products![index].off! > 0
                  ? calculateDiscount(
                      category.products![index].price!.toDouble(),
                      category.products![index].off!.toDouble()) as double
                  : null,
            ),
          ),
        )
      ],
    );
  }
}

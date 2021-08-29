import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_status.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/widgets/product_item.dart';

class SubcategoryProductsList extends StatelessWidget {
  final List<ProductModel> products;
  final ScrollController scrollController;
  final Function addProductToBasket;
  final Function removeFromBasket;
  final Function browseProduct;
  final Function countInBasket;

  const SubcategoryProductsList(
      this.products,
      this.scrollController,
      this.addProductToBasket,
      this.removeFromBasket,
      this.browseProduct,
      this.countInBasket);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 17, left: 12, right: 12),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: Get.width / 3,
                mainAxisExtent: Get.height * 0.25,
                mainAxisSpacing: 5,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductItem(
                  products[index],
                  addProductToBasket,
                  removeFromBasket,
                  browseProduct,
                  countInBasket(products[index].id!) as int)),
        ],
      ),
    );
  }
}

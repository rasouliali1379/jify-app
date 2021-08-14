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
  final Function calculateDiscount;
  final String pagginationStatus;

  const SubcategoryProductsList(
      this.products,
      this.scrollController,
      this.addProductToBasket,
      this.removeFromBasket,
      this.browseProduct,
      this.countInBasket,
      this.calculateDiscount,
      this.pagginationStatus);

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
                childAspectRatio: 110 / 204,
                mainAxisSpacing: 5,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductItem(
                    products[index],
                    addProductToBasket,
                    removeFromBasket,
                    browseProduct,
                    countInBasket(products[index].id!) as int,
                    discountedPrice: products[index].off! > 0
                        ? calculateDiscount(products[index].price!.toDouble(),
                            products[index].off!.toDouble()) as double
                        : null,
                  )),
          if (pagginationStatus == AppStatus.loading)
            const SpinKitRing(color: AppColors.blue)
          else if (pagginationStatus == AppStatus.tryAgain)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.blue)),
              child: SvgPicture.asset('assets/icons/refresh.svg'),
            )
          else
            const SizedBox()
        ],
      ),
    );
  }
}

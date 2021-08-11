import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/widgets/change_address_container.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';
import 'package:jify_app/widgets/category_grid_item.dart';
import 'package:jify_app/widgets/product_item.dart';
import 'package:jify_app/widgets/subcategory_list.dart';
import 'package:jify_app/widgets/subcategory_products_list.dart';
import 'package:jify_app/widgets/subcategory_row_list.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with AutomaticKeepAliveClientMixin {
  final _controller = Get.find<HomeFragmentController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<HomeFragmentController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
            controller.onAppBarBackPressed,
            controller.clearSearch,
            controller.searchChangeHandler,
            controller.searchTextController,
            controller.searchFocusNode),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            // AddressContainer(
            //   RichText(
            //     text: TextSpan(
            //         style: AppTextStyles.lightPurple11Normal500,
            //         children: [
            //           const TextSpan(text: 'Delivery to '),
            //           TextSpan(
            //               text: 'Bouazar ST 305',
            //               style: AppTextStyles.lightPurple11Normal500
            //                   .copyWith(decoration: TextDecoration.underline)),
            //           const TextSpan(text: ' within 15 minutes')
            //         ]),
            //   ),
            // ),
            ChangeAddressContainer(
                _controller.mainController.openDeliveryAddressModal),
            Builder(builder: (context) {
              switch (controller.pageMode) {
                case "search":
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          bottom: 17, left: 12, right: 12),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: Get.width / 3,
                        childAspectRatio: 110 / 204,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: _controller.searchedProducts.length,
                      itemBuilder: (context, index) => ProductItem(
                          controller.searchedProducts[index],
                          controller.addProductToBasket,
                          controller.removeFromBasket,
                          controller.browseProduct,
                          controller.productRepository.countInBasket(
                              _controller.searchedProducts[index].id!)));
                case "subcategory_products":
                  return Column(
                    children: [
                      Obx(() => SubCategoryRowList(
                          _controller.subCategories,
                          _controller.onSubcategoryItemClickHandler,
                          _controller.selectedSubcategory)),
                      SubcategoryProductsList(
                          controller
                              .subCategories[controller.selectedSubcategory]
                              .products!,
                          controller.scrollController,
                          controller.addProductToBasket,
                          controller.removeFromBasket,
                          controller.browseProduct,
                          controller.productRepository.countInBasket),
                    ],
                  );
                case "subcategory":
                  return Column(
                    children: [
                      Obx(() => SubCategoryRowList(
                          _controller.subCategories,
                          _controller.onSubcategoryItemClickHandler,
                          _controller.selectedSubcategory)),
                      SubcategoryList(
                          controller.subCategories,
                          controller.onSubcategoryItemClickHandler,
                          controller.addProductToBasket,
                          controller.removeFromBasket,
                          controller.browseProduct,
                          controller.productRepository.countInBasket),
                    ],
                  );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(Get.width * 0.0426),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Get.width / 2,
                    childAspectRatio: 163 / 95,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16),
                itemCount: controller.categoryItems.length,
                itemBuilder: (context, index) => CategoryGridItem(
                    controller.categoryItems[index].title!,
                    controller.categoryItems[index].image!,
                    controller.onCategoryItemClickHandler,
                    index),
              );
            })
          ],
        ),
      );
    });
  }
}

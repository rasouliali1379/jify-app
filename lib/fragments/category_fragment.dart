import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/widgets/product_item.dart';
import 'package:jify_app/widgets/subcategory_product_row_list_item.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';
import 'package:jify_app/widgets/subcategory_row_list.dart';
import 'package:jify_app/widgets/change_address_container.dart';

class CategoryFragment extends GetView<CategoryFragmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller.backClickHandler,
      ),
      body: Column(
        children: [
          ChangeAddressContainer(
              controller.mainPageController.openDeliveryAddressModal),
          Obx(() => SubCategoryRowList(
              controller.subCategories,
              controller.onSubcategoryItemClickHandler,
              controller.selectedSubcategory)),
          Expanded(
            child: GetBuilder<CategoryFragmentController>(
                builder: (_) => controller.selectedSubcategory > -1
                    ? subcategoryProducts()
                    : subcategories()),
          )
        ],
      ),
    );
  }

  Widget subcategories() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.subCategories.length,
        itemBuilder: (context, index) => SubcategoryProductRowList(
            controller.subCategories[index],
            controller.onSubcategoryItemClickHandler,
            controller.addProductToBasket,
            controller.removeFromBasket,
            controller.browseProduct,
            index));
  }

  Widget subcategoryProducts() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 17, left: 12, right: 12),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Get.width / 3,
          childAspectRatio: 110 / 204,
          mainAxisSpacing: 5,
        ),
        itemCount: controller
            .subCategories[controller.selectedSubcategory].products!.length,
        itemBuilder: (context, index) => ProductItem(
            controller
                .subCategories[controller.selectedSubcategory].products![index],
            controller.addProductToBasket,
            controller.removeFromBasket,
            controller.browseProduct,
            controller.productRepository.countInBasket(controller
                .subCategories[controller.selectedSubcategory]
                .products![index]
                .id!)));
  }
}

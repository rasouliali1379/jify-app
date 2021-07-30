import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/widgets/category_product_row_list_item.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';
import 'package:jify_app/widgets/subcategory_row_list.dart';
import 'package:jify_app/widgets/change_address_container.dart';
import 'package:jify_app/widgets/product_item.dart';

class CategoryFragment extends GetView<CategoryFragmentController> {
  final list = ['Ice Cream', 'Drinks', 'Biscuits', 'Snacks', 'Pantry'];

  final productList = [
    const ProductItem(
        'assets/images/doritos1.png', 'Doritos Nacho Cheese 170g', '\$4.99'),
    const ProductItem('assets/images/doritos2.png',
        'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
    const ProductItem(
        'assets/images/doritos3.png', 'Smiths Salt & Vinegar 170g', '\$1.99'),
    const ProductItem(
        'assets/images/doritos1.png', 'Doritos Nacho Cheese 170g', '\$4.99'),
    const ProductItem('assets/images/doritos2.png',
        'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
    const ProductItem(
        'assets/images/doritos3.png', 'Smiths Salt & Vinegar 170g', '\$1.99'),
    const ProductItem(
        'assets/images/doritos1.png', 'Doritos Nacho Cheese 170g', '\$4.99'),
    const ProductItem('assets/images/doritos2.png',
        'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
    const ProductItem(
        'assets/images/doritos3.png', 'Smiths Salt & Vinegar 170g', '\$1.99'),
    const ProductItem(
        'assets/images/doritos1.png', 'Doritos Nacho Cheese 170g', '\$4.99'),
    const ProductItem('assets/images/doritos2.png',
        'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
    const ProductItem(
        'assets/images/doritos3.png', 'Smiths Salt & Vinegar 170g', '\$1.99'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        () => {},
      ),
      body: Column(
        children: [
          ChangeAddressContainer(
              controller.mainPageController.openDeliveryAddressModal),
          Obx(() => SubCategoryRowList(
              list,
              controller.onCategoryItemClickHandler,
              controller.selectedCategory)),
          Expanded(
            child: Obx(() => controller.selectedCategory.isNotEmpty
                ? subCategoriesList()
                : categoriesList()),
          )
        ],
      ),
    );
  }

  Widget categoriesList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) =>
            CategoryProductRowList(list[index], () => {}, productList));
  }

  Widget subCategoriesList() {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.only(bottom: 17, left: 12, right: 12),
      // cacheExtent: Get.height * 0.2512,
      childAspectRatio: 110 / 204,
      mainAxisSpacing: 5,
      children: productList,
    );
  }
}

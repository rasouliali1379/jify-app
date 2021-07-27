import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/widgets/category_row_list.dart';
import 'package:jify_app/widgets/change_address_container.dart';
import 'package:jify_app/widgets/product_item.dart';

class CategoryFragment extends GetView<CategoryFragmentController> {
  final list = ['Ice Cream', 'Drinks', 'Biscuits', 'Snacks', 'Pantry'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChangeAddressContainer(() => {}),
        Obx(() => CategoryRowList(list, controller.onCategoryItemClickHandler,
            controller.selectedCategory)),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.all(17),
            // cacheExtent: Get.height * 0.2512,
            childAspectRatio: 110/204,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            children: [
              const ProductItem('assets/images/doritos1.png',
                  'Doritos Nacho Cheese 170g', '\$4.99'),
              const ProductItem('assets/images/doritos2.png',
                  'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
              const ProductItem('assets/images/doritos3.png',
                  'Smiths Salt & Vinegar 170g', '\$1.99'),
              const ProductItem('assets/images/doritos1.png',
                  'Doritos Nacho Cheese 170g', '\$4.99'),
              const ProductItem('assets/images/doritos2.png',
                  'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
              const ProductItem('assets/images/doritos3.png',
                  'Smiths Salt & Vinegar 170g', '\$1.99'),
              const ProductItem('assets/images/doritos1.png',
                  'Doritos Nacho Cheese 170g', '\$4.99'),
              const ProductItem('assets/images/doritos2.png',
                  'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
              const ProductItem('assets/images/doritos3.png',
                  'Smiths Salt & Vinegar 170g', '\$1.99'),
              const ProductItem('assets/images/doritos1.png',
                  'Doritos Nacho Cheese 170g', '\$4.99'),
              const ProductItem('assets/images/doritos2.png',
                  'Red Rock Deli Sweet Chilli & S...', '\$5.49'),
              const ProductItem('assets/images/doritos3.png',
                  'Smiths Salt & Vinegar 170g', '\$1.99'),
            ],
          ),
        )
      ],
    );
  }
}

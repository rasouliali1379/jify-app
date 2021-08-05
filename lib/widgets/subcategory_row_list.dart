import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/widgets/subcatergory_row_list_item.dart';

class SubCategoryRowList extends StatelessWidget {
  final List<CategoryModel> items;
  final int selected;
  final Function onClick;

  const SubCategoryRowList(this.items, this.onClick, this.selected);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.076,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => SubCategoryRowListItem(
            items[index].title!, selected == index, onClick, index),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/widgets/catergory_row_list_item.dart';

class CategoryRowList extends StatelessWidget {
  final List<String> items;
  final String selected;
  final Function onClick;

  const CategoryRowList(this.items, this.onClick, this.selected);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.076,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => CategoryRowListItem(
            items[index], selected == items[index], onClick),
      ),
    );
  }
}

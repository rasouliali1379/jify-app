import 'package:flutter/material.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/widgets/subcategory_product_row_list_item.dart';

class SubcategoryList extends StatelessWidget {
  final List<CategoryModel> subcategories;
  final Function onSubcategoryItemClickHandler;
  final Function addProductToBasket;
  final Function removeFromBasket;
  final Function browseProduct;
  final Function countInBasket;

  const SubcategoryList(this.subcategories, this.onSubcategoryItemClickHandler, this.addProductToBasket,
      this.removeFromBasket, this.browseProduct, this.countInBasket);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: subcategories.length,
        itemBuilder: (context, index) => SubcategoryProductRowList(subcategories[index], onSubcategoryItemClickHandler,
            addProductToBasket, removeFromBasket, browseProduct, countInBasket, index));
  }
}

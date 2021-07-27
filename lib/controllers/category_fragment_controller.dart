import 'package:get/get.dart';

class CategoryFragmentController extends GetxController {
  final _selectedCategory = "".obs;

  String get selectedCategory => _selectedCategory.value;

  set selectedCategory(String value) {
    _selectedCategory.value = value;
  }

  void onCategoryItemClickHandler(String category) {
    print(category);
    selectedCategory = category;
  }
}

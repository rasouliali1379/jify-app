import 'package:get/get.dart';
import 'package:jify_app/controllers/main_page_controller.dart';

class CategoryFragmentController extends GetxController {

  final mainPageController = Get.find<MainPageController>();

  final _selectedCategory = "".obs;

  String get selectedCategory => _selectedCategory.value;

  set selectedCategory(String value) {
    _selectedCategory.value = value;
  }

  void onCategoryItemClickHandler(String category) {
    if (category == selectedCategory) {
      selectedCategory = "";
    } else {
      selectedCategory = category;
    }
  }
}

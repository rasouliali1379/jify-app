import 'package:get/get.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/category_model.dart';

class HomeFragmentController extends GetxController {
  final _categoryController = Get.find<CategoryFragmentController>();
  final _mainController = Get.find<MainPageController>();
  final _globalController = Get.find<GlobalController>();

  final _categoryItems = <CategoryModel>[].obs;

  @override
  void onInit() {
    categoryItems = _globalController.initialDataModel.categories!;
    super.onInit();
  }

  List<CategoryModel> get categoryItems => _categoryItems.value;

  set categoryItems(List<CategoryModel> value) {
    _categoryItems.value = value;
  }

  Function() onCategoryItemClickHandler(int index) {
    return () {
      _categoryController.populateData(index);
      _mainController.pageStack.add(3);
      _mainController.pageController.jumpToPage(3);
      _mainController.backBtnVisibility = true;
    };
  }
}

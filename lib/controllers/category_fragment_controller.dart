import 'package:get/get.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/product_repository.dart';

class CategoryFragmentController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final mainPageController = Get.find<MainPageController>();
  final productRepository = ProductRepository();

  final _selectedSubcategory = (-1).obs;

  final _subCategories = <CategoryModel>[].obs;

  void populateData(int index) {
    subCategories =
        globalController.initialDataModel.categories![index].subCategories!;
  }

  List<CategoryModel> get subCategories => _subCategories.value;

  set subCategories(List<CategoryModel> value) {
    _subCategories.value = value;
  }

  int get selectedSubcategory => _selectedSubcategory.value;

  set selectedSubcategory(int value) {
    _selectedSubcategory.value = value;
  }

  void onSubcategoryItemClickHandler(int categoryIndex) {
    if (categoryIndex == selectedSubcategory) {
      selectedSubcategory = -1;
    } else {
      selectedSubcategory = categoryIndex;
    }
    update();
  }

  void backClickHandler() {
    mainPageController.pageController.jumpToPage(0);
    mainPageController.backBtnVisibility = false;
    mainPageController.pageStack.removeLast();
  }

  void addProductToBasket(ProductModel product, {int count = 1}) {
    for (int i = 0; i < count; i++) {
      globalController.basket.add(product);
    }
    update();
  }

  void removeFromBasket(String id) {
    productRepository.removeProductFromBasket(id);
    update();
  }

  void browseProduct(ProductModel product) {
    Get.toNamed(Routes.product,
        preventDuplicates: true, arguments: product.toJson());
  }
}

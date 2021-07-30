import 'package:get/get.dart';
import 'package:jify_app/controllers/main_page_controller.dart';

class HomeFragmentController extends GetxController {

  final _mainController = Get.find<MainPageController>();

  void onCategoryItemClickHandler(){
    _mainController.pageStack.add(3);
    _mainController.pageController.jumpToPage(3);
    _mainController.backBtnVisibility = true;
  }

  void backClickHandler() {
    if (_mainController.pageController.page == 3) {
      _mainController.pageController.jumpToPage(0);
      _mainController.backBtnVisibility = false;
    }

    _mainController.pageStack.removeLast();
  }
}
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  final _count = 0.obs;

  int get count => _count.value;

  set count(int value) {
    _count.value = value;
  }

  void increaseCount() {
    count++;
  }

  void decreaseCount() {
    if (count != 0) {
      count--;
    }
  }
}

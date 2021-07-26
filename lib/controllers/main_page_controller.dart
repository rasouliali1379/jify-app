import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  final _index = 0.obs;
  final pageController = PageController();

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
  }

  onBottomNavClickHandle(int value) {
    index = value;
    pageController.jumpToPage(index);
  }
}

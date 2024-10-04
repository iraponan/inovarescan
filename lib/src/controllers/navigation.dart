import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(pageController: PageController(initialPage: NavigationTabs.home.index), currentIndex: NavigationTabs.home.index);
  }

  void _initNavigation({required PageController pageController, required int currentIndex}) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  void navigatePageView({required int page}) {
    if (_currentIndex.value == page) {
      return;
    }
    _pageController.animateToPage(page, duration: VariablesUtils.pageAnimationDuration, curve: Curves.slowMiddle);
    _currentIndex.value = page;
  }
}

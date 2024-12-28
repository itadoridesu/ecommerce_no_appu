import 'package:ecommerce_no_shoppu/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {

  static OnBoardingController get instace => Get.find();

  // Variables
  final pageController = PageController();

  Rx<int> currentPageIndex = 0.obs;

  // Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;


  // Jump to the specified dot selected page:
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    int page = index;
    pageController.animateToPage(
        page,
        duration:
            const Duration(milliseconds: 450), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
  }


  // Update current index and jump to next page
  void nextPage() {
    if(currentPageIndex == 2) {
      
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());

    } else {
      int page = currentPageIndex.value + 1;
       pageController.animateToPage(
        page,
        duration:
            const Duration(milliseconds: 450), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
    }


  }


  // Update current index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.animateToPage(
        2,
        duration:
            const Duration(milliseconds: 450), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
  }

}


import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> carousalCurentIndex = 0.obs;

  void updateImageIndicator (index) {
    carousalCurentIndex.value = index;
  }
}

import 'package:ecommerce_no_shoppu/data/repositories/user/user_repisitory.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/user_controller.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/profile.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/network_manager.dart';
import 'package:ecommerce_no_shoppu/utils/popups/full_screen_loder.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = UserRepository.instance;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen appears
  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are updating your information...', 'assets/images/animations/loader-animation.json');

      // Check internet connectiviy
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) { 
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validity
      if (!updateUserNameFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
     
      await userRepository.updateSingleField(name);
     
      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
           
      // Remove Loader
      TFullScreenLoader.stopLoading();


      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your Name has been updated desu yo.',
      );

      Get.off(() => const ProfileScreen());

 
    } catch (e) {

      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }
}

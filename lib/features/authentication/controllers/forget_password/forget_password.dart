import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/reset_password.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/network_manager.dart';
import 'package:ecommerce_no_shoppu/utils/popups/full_screen_loder.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  // Singleton instance for GetX dependency injection
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController(); // Fixed declaration for email controller
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start loading indicator
      TFullScreenLoader.openLoadingDialog('Processing your request...', 'assets/images/animations/loader-animation.json');

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }


      // Send email to reset password 
      await AuthenticationRepository.instance.sendPasswordRestEmail(email.text.trim());


      TFullScreenLoader.stopLoading();


      TLoaders.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password'.tr);

      Get.to(() => ResetPassword(email: email.text.trim(),));


    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Resend Password Reset Email (Example)
  resendPasswordResetEmail(String email) async {
    try {
      // Start loading indicator
      TFullScreenLoader.openLoadingDialog('Processing your request...', 'assets/images/animations/loader-animation.json');

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      // Send email to reset password 
      await AuthenticationRepository.instance.sendPasswordRestEmail(email);


      TFullScreenLoader.stopLoading();


      TLoaders.successSnackBar(title: 'Email sent', message: 'Email link sent to reset your password'.tr);



    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

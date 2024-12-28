import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/user_controller.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/network_manager.dart';
import 'package:ecommerce_no_shoppu/utils/popups/full_screen_loder.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  /// variables
  final rememeberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }

  /// Email and Password Sign In ---
  Future<void> emalAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog('Loggin you innu desu...', 'assets/images/animations/loader-animation.json');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validity
      if (!loginFormKey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememeberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

      TLoaders.successSnackBar(title: 'YAAAY', message: 'You successfully logged in lil bro hhhhh');

    } catch (e) {

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Error Snackbar
      TLoaders.errorSnackBar(
        title: 'Oh Snap',
        message: e.toString(),
      );
    }
  }

  Future<void> googleSignIn() async {
    try {

    TFullScreenLoader.openLoadingDialog('Loggin you innu desu...', 'assets/images/animations/loader-animation.json');

    final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

    // Google authentication
    final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

    // Save user record
    await userController.saveUserRecord(userCredentials);

    TFullScreenLoader.stopLoading();

    AuthenticationRepository.instance.screenRedirect();

    TLoaders.successSnackBar(title: 'YAAAY', message: 'You successfully logged in using your Google Account lil bro hhhhh');

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Sunappu!', message: e.toString());
    }
  }
}


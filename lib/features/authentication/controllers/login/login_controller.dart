import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/user_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/network_manager.dart';
import 'package:ecommerce_no_shoppu/utils/popups/full_screen_loder.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

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


    final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

    // Google authentication
    final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

     if (userCredentials == null) {
      return;
      }

    TFullScreenLoader.openLoadingDialog('Loggin you innu desu...', 'assets/images/animations/loader-animation.json');


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

  /// Logout Warning
void logoutWarningPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.lightContainer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.md)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimize the height of the dialog
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: THelperFunctions.isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    Text(
                      'Are you sure you want to log out? You will be redirected to the login screen.',
                      style: TextStyle(
                        color: THelperFunctions.isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(flex: 2, child: SizedBox()),
                    // Cancel Button
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back(); // Close the dialog
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(
                        width: TSizes.sm), // Add space between buttons
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          AuthenticationRepository.instance.logout(); // Call the logout function
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                          padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


}


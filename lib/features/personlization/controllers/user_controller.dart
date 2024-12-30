import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/data/repositories/user/user_repisitory.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/login.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/widgets/re_auth_user_login_form.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/network_manager.dart';
import 'package:ecommerce_no_shoppu/utils/popups/full_screen_loder.dart';
import 'package:ecommerce_no_shoppu/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// next time we are gonna check if this user is stored already, if so: this function shoudl not be triggered.

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUpoading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;

      final fetchedUser = await userRepository.fetchUserDetails();
      user.value = fetchedUser;
    } catch (e) {
      user.value = UserModel.empty();
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record from google provider only desu
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert name to first and last name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    showDialog(
      context: Get.context!,
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
              mainAxisSize:
                  MainAxisSize.min, // Minimize the height of the dialog
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'Delete Account',
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
                        'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
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
                            padding:
                                const EdgeInsets.symmetric(vertical: TSizes.sm),
                            side: const BorderSide(color: Colors.red),
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
                            Get.back();
                            deleteUserAccount(); // Call the delete account function
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding:
                                const EdgeInsets.symmetric(vertical: TSizes.sm),
                          ),
                          child: const Text('Delete'),
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

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are updating your information...',
          'assets/images/animations/loader-animation.json');

      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re-verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
            title: 'Your account has been deleted!',
            message:
                'We are sorry to see you go. Your data has been removed successfully.',
          );
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  /// Re-authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are updating your information...',
          'assets/images/animations/loader-animation.json');

      // Check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate form input
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Re-authenticate with email and password
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
        verifyEmail.text.trim(),
        verifyPassword.text.trim(),
      );

      // Delete user account
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Your account has been deleted!',
        message:
            'We are sorry to see you go. Your data has been removed successfully.',
      );

      // Navigate to Login screen after successful deletion
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  /// Upload Profile Image
  Future<void> uploadUserProfilePicture() async {
    try {
      // Pick image from gallery in one line
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 78);

      if (image != null) {

        imageUpoading.value = true;
        // Upload Image to firebase storage in the corresponding path
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record (in firebase firestore)
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // Update user profile picture in the UI
        user.value.profilePicture = imageUrl;
        user.refresh();

        // Show success snackbar
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Image has been updated!',);
      }

    } catch (e) {
      // Show error snackbar
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e',);
    } finally {
      imageUpoading.value = false;
    }
  }
}

import 'package:ecommerce_no_shoppu/common/styles/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/user_controller.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/widgets/change_name.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;


    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture Section
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : TImages.user;
                        return controller.imageUpoading.value
                            ? const CustomShimmerEffect(width: 80, height: 80, radius: 80,)
                            : ClipOval(
                                child: CircularImage(
                                  image: image,
                                  width: 80,
                                  height: 80,
                                  padding: 0,
                                  isNetworkImage: networkImage.isNotEmpty,
                                ),
                              );
                      },
                    ),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              // Profile Infomration Section
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const SectionHeading(
                  title: 'Profile Information', showActionButton: false),

              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() => ProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onTap: () => Get.to(() => const ChangeName()))),
              Obx(() => ProfileMenu(
                  title: 'Username',
                  value: controller.user.value.username,
                  onTap: () {})),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Personam Info Section
              const SectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() => ProfileMenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onTap: () {})),
              Obx(() => ProfileMenu(
                  title: 'E-mail',
                  value: controller.user.value.email,
                  onTap: () {})),
              Obx(() => ProfileMenu(
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber,
                  onTap: () {})),
              ProfileMenu(title: 'Gender', value: 'Male', onTap: () {}),
              ProfileMenu(
                  title: 'Date of Birth', value: '10 Oct, 1994', onTap: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => controller.deleteAccountWarningPopup(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

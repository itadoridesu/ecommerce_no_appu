import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const ClipOval(
                      child: CircularImage(
                          image: TImages.user, width: 80, height: 80, padding: 0,),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle profile picture change action
                      },
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
              ProfileMenu(title: 'Name', value: 'dmdm', onTap: () {}),
              ProfileMenu(
                  title: 'Username', value: 'dmdm_hh', onTap: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Personam Info Section
              const SectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              ProfileMenu(
                  title: 'User ID',
                  value: '45689',
                  icon: Iconsax.copy,
                  onTap: () {}),
              ProfileMenu(
                  title: 'E-mail', value: 'ademhamizi2005@gmail.com', onTap: () {}),
              ProfileMenu(
                  title: 'Phone Number',
                  value: '+213 794227879',
                  onTap: () {}),
              ProfileMenu(title: 'Gender', value: 'Male', onTap: () {}),
              ProfileMenu(
                  title: 'Date of Birth', value: '10 Oct, 1994', onTap: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),

               Center(
                child: TextButton(
                  child: const Text('Close Account', style: TextStyle(color: Colors.red),),
                  onPressed: () {}, ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

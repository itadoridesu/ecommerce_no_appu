import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/primary_header_cotainer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:ecommerce_no_shoppu/common/widgets/list_tiles/settings_tile.dart';
import 'package:ecommerce_no_shoppu/common/widgets/list_tiles/user_profile.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/address/address.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/order/orders.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/profile/profile.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),

              // Header
              child: primaryHeaderContainer(
                child: Column(
                  children: [
                    // Appu Baa
                    CustomAppBar(
                      title: Text(
                        'Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white),
                      ),
                    ),

                    // User Profile Caado
                    UserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),

                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ),

            // Body Desu Yo
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // Appu Settingsu
                  SettingsTile(
                      icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address', onTap: () => Get.to(() => const UserAdressScreen()),),
                  const SettingsTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'Add, remove products and move to checkout'),
                  SettingsTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders',
                      onTap: () => Get.to(() => const OrderScreen()),
                      ),
                  const SettingsTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account'),
                  const SettingsTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons'),
                  const SettingsTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message'),
                  const SettingsTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  const SectionHeading(
                      title: 'App Settings', showActionButton: false),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  const SettingsTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase'),
                  SettingsTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ), // SettingsTile

                  SettingsTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ), // SettingsTile

                  SettingsTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => controller.logoutWarningPopup(context), child: const Text('Logout')),
                  ), // SizedBox
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

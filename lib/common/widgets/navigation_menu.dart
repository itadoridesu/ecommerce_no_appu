import 'package:ecommerce_no_shoppu/features/shop/screens/home/home.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/settings/settings.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/store/store.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BottomNavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: THelperFunctions.screenHeight() * 0.08,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black: Colors.white,
          indicatorColor: dark?TColors.white.withOpacity(.1) : Colors.black.withOpacity(.1),
          destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home', selectedIcon: Icon(Iconsax.home_15,),),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop', selectedIcon: Icon(Iconsax.shop5,),),
          NavigationDestination(icon: Icon(Iconsax.lovely), label: 'Wishlist', selectedIcon: Icon(Iconsax.lovely5,),),
          NavigationDestination(icon: Icon(CupertinoIcons.person), label: 'Profile', selectedIcon: Icon(CupertinoIcons.person_fill,),),
          ]
          ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value])
    );
  }
}

class BottomNavigationController extends GetxController {
  static BottomNavigationController get instace => Get.find();

  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [const HomeScreen(), const StoreScreen(), const FavouriteScreen(), const SettingsScreen()];
}





import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/loaders/animation_loaders.dart';
import 'package:ecommerce_no_shoppu/common/widgets/navigation_menu.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_vertical.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/favorite_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              BottomNavigationController.instace.selectedIndex.value = 0;
              Get.to(() => const NavigationMenu());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.getfavoriteProducts(),
                    builder: (context, snapshot) {
                      /// Nothing Found Widget
                      final emptyWidget = TAnimationLoaderWidget(
                        text: 'Whoops! Wishlist is Empty...',
                        animation: TImages.pencilAnimation,
                        showAction: true,
                        actionText: 'Let\'s add some kudasai!',
                        onActionPressed: () {
                          BottomNavigationController.instace.selectedIndex.value = 0;
                          Get.to(() => const NavigationMenu());
                        },
                      );

                      const loader = VerticalProductShimmer();

                      final widget =
                          TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget,
                      );

                      if (widget != null) return widget;

                      final favoriteProducts = snapshot.data!;

                      return GridLayout(
                        itemCount:
                            favoriteProducts.length, // Specify an item count
                        itemBuilder: (_, index) => ProductCardVertical(
                            productModel: favoriteProducts[index]),
                        mainAxisExtent: 288,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

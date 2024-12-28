import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/tabbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/cart/cart_menu_icon.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/brand/all_brands.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCountIcon(
                // onPressed: () {},
                iconColor: dark ? TColors.light : TColors.black)
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const SearchContainer(
                        text: 'Search in Store',
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      SectionHeading(
                        title: 'Feature Brands',
                        onPressed: () {},
                        showActionButton: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      GridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return BrandCard(
                              showBorder: true,
                              onTap: () => Get.to(() => const AllBrandsScreen()),
                            );
                          })
                    ],
                  ),
                ),
              ),
              const SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  toolbarHeight: 0,
                  bottom: CustomTabBar(tabs: [
                    Tab(
                      child: Text('Sports'),
                    ),
                    Tab(
                      child: Text('Furniture'),
                    ),
                    Tab(
                      child: Text('Electronics'),
                    ),
                    Tab(
                      child: Text('Clothes'),
                    ),
                    Tab(
                      child: Text('Cosmetics'),
                    ),
                  ]))
            ];
          },
          body: const TabBarView(
            children: [
              CategoryTab(), CategoryTab(), CategoryTab(), CategoryTab(), CategoryTab()

            ],
          ),
        ),
      ),
    );
  }
}





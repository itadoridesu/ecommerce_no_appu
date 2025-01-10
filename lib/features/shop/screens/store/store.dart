import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/tabbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/cart/cart_menu_icon.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/brand_shimmer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/category_controller.dart';
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
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
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
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                        showActionButton: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                        Obx(
                        () {

                          if(brandController.isLoading.value) return const BrandsShimmer(); 

                          if(brandController.featuredBrands.isEmpty) {
                            return Center(child: Text('No Data Found desu yo!', style: Theme.of(context).textTheme.bodyMedium,),);
                          }
                          
                          return GridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return BrandCard(
                                brand: brand,
                                showBorder: true,
                                onTap: () => Get.to(() => const AllBrandsScreen()),
                              );
                            });

                        } ,
                      )
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  toolbarHeight: 0,
                  bottom: CustomTabBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList())
                  )
            ];
          },
          body: TabBarView(
            children: categories.map((category) => CategoryTab(categoryModel: category)).toList(),
          ),
        ),
      ),
    );
  }
}





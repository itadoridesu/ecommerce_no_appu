import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/primary_header_cotainer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/search_bar_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_vertical.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: const primaryHeaderContainer(
                  child: Column(
                children: [
                  // HOME APP BAR
                  HomeAppBar(),

                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // SEARCH BAR
                  SearchContainer(text: 'Search in Store'),

                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //CATEGORIES
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        HomeCategories(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  SectionHeading(
                    title: 'Popular Products',
                    showActionButton: true,
                    onPressed: () => Get.to(() => AllProducts(
                          title: 'Popular Products',
                          query: FirebaseFirestore.instance.collection('Products'),
                          futureMehtod: controller.fetchAllProducts(),
                        )),
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// -- Popular Products
                  Obx(() {
                    if (controller.isLoading.value)
                      return const VerticalProductShimmer();

                    if (controller.featuredProducts.isEmpty)
                      return Center(
                          child: Text(
                        'No data found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ));

                    return GridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                          productModel: controller.featuredProducts[index]),
                      mainAxisExtent: 288,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

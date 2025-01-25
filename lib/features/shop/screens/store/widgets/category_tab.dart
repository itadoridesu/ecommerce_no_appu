import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_vertical.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/store/widgets/category_brands.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(shrinkWrap: true, children: [
        Column(
          children: [
            // Brands
            CategoryBrands(category: categoryModel),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            FutureBuilder(
                future: controller.getCategoryProducts(
                    categoryId: categoryModel.id),
                builder: (context, snapshot) {
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: const VerticalProductShimmer());
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return Column(
                    children: [
                      SectionHeading(
                        title: 'You might like',
                        onPressed: () => Get.to(() => AllProducts(
                              title: categoryModel.name,
                              futureMehtod: controller.getCategoryProducts(
                                  categoryId: categoryModel.id, limit: -1),
                            )),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      GridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            ProductCardVertical(productModel: products[index]),
                        mainAxisExtent: 288,
                      ),
                    ],
                  );
                }),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            )
          ],
        ),
      ]),
    );
  }
}

import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/widgets/product_meta.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/widgets/ratings_share_widget.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:ecommerce_no_shoppu/utils/constants/enums.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScrenn extends StatelessWidget {
  const ProductDetailsScrenn({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            ProductImageSlider(productModel: productModel,),

            /// 2-Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating & Share Button
                  const RatingsAndShare(),

                  // Price, Title, Stack & Brand
                  ProductMetaData(productModel: productModel,),

                  // Attributes
                  if(productModel.productType == ProductType.variable.toString()) ProductAttributes(productModel: productModel,),
                  if(productModel.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwItems,) else const SizedBox(height: 10,),

                  // CheckOut Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // Description
                  const SectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    productModel.description ?? 'HOHO no descurippushun desu :(',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ), 

                  // Reviews
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeading(
                          title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () {
                          Get.to(() => const ProductReviewsScreen());
                        },
                      ),
                    ],
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


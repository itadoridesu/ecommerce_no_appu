import 'package:ecommerce_no_shoppu/common/styles/shadow.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/rounded_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_title.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_details/product_details.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/enums.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(productModel.price, productModel.salePrice);

    print(productModel.thumbnail);  // Debugging the thumbnail URL



    /// Container with side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScrenn(productModel: productModel,)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ), // BoxDecoration
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            CircularContainer(
              height: 180,
              radius: TSizes.productImageRadius,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  Center(
                    child: RoundedImage(
                        imageUrl: productModel.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true,
                        backgroundColor: dark ? TColors.dark : TColors.light),
                  ),

                  /// Sale Tag
                  Positioned(
                    top: 12,
                    child: CircularContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.sm),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  /// Heart Icon
                  const Positioned(
                      right: 0,
                      top: 2,
                      child: CircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      )),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),

            // Details Section
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  ProductTitleText(title: productModel.title, smallSize: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // Brand Row
                  Row(
                    children: [
                      Text(
                        productModel.brand!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(width: TSizes.xs),
                      const Icon(
                        Iconsax.verify5,
                        color: TColors.primary,
                        size: TSizes.iconXs,
                      ),
                    ],
                  ), // Row
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price Flexible
                Column(
                  children: [
                    if (productModel.productType == ProductType.single.toString() && productModel.salePrice > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: Text(
                          productModel.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(decoration: TextDecoration.lineThrough),
                        ), // Text
                      ), // Padding
                
                    /// Price, Show sale price as main price if sale exists.
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: ProductPriceText(
                          price: controller.getProductPrice(productModel)),
                    ), // Padding
                  ],
                ),

                // Add-to-Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ), // BorderRadius.only
                  ), // BoxDecoration
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(Iconsax.add, color: TColors.white),
                    ), // Center
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

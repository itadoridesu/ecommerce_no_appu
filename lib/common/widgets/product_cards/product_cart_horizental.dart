import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/rounded_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/brand_title_with_verification.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_title.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartHorizental extends StatelessWidget {
  const ProductCartHorizental({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.softGrey.withOpacity(.7),
      ),
      child: Row(
        children: [
          /// Thumbnail
          CircularContainer(
            radius: 16,
            height: 120,
            padding: const EdgeInsets.all(2),
            backgroundColor: dark ? TColors.dark : TColors.white,
            child: Stack(
              children: [
                /// -- Thumbnail Image
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: RoundedImage(
                    imageUrl: TImages.productImage1,
                    applyImageRadius: true,
                  ),
                ),

                /// Sale Tag
                Positioned(
                  left: 2,
                  top: 2,
                  child: CircularContainer(
                    radius: 16,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.sm),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ),
                ),

                /// Heart Icon
                const Positioned(
                    right: 2,
                    top: 2,
                    child: CircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                      height: 40,
                      width: 40,
                    )),
              ],
            ),
          ),

          /// Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, top: TSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 4),
                        child:  ProductTitleText(
                          title: 'Green Nike Half Sleeves Shirt ',
                          smallSize: true, 
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      BrandTitleWithVerification(title: 'Nike'),
                    ],                    
                  ),
            
                  const Spacer(),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const Flexible(child: ProductPriceText(price: '256.0')),
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
                    ), 
                  ), 
                ), 
                    ],
                  ), 
                ],
              ), 
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/brand/brand_products.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({super.key, required this.images, required this.brand});

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => BrandProducts(brandModel: brand)),
      child: CircularContainer(
        backgroundColor: Colors.transparent,
        showBorder: true,
        radius: 16,
        borderColor: TColors.darkGrey,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            //Brands with products count
            BrandCard(
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
      
            Row(
                children: images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Expanded(
      child: CircularContainer(
        radius: 16,
        height: 100,
        backgroundColor: dark ? TColors.darkContainer : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, downloadProgress) => const CustomShimmerEffect(width: 100, height: 100),
          errorWidget:(context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

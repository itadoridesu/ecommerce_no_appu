import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key, required this.images,
    });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      backgroundColor: Colors.transparent,
      showBorder: true,
      radius: 16,
      borderColor: TColors.darkGrey,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          //Brands with products count
          const BrandCard(showBorder: false),  
          const SizedBox(height: TSizes.spaceBtwItems,),   
    
    
          Row(
            children: images.map((image) => brandTopProductImageWidget(image, context)).toList()
          )  
        ],
    
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
                child: Image(fit: BoxFit.contain, image: AssetImage(image)),
              ),
            );
  }
}
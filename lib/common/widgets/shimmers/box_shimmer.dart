import 'package:ecommerce_no_shoppu/common/widgets/shimmers/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BoxShimmer extends StatelessWidget {
  const BoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
            SizedBox(width: TSizes.spaceBtwItems),
            Expanded(child: CustomShimmerEffect(width: 150, height: 110)),
          ],
        ), 
      ],
    ); 
  }
}

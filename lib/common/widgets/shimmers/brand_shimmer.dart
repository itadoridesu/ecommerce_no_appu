import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/custom_shimmer_effect.dart';
import 'package:flutter/material.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const CustomShimmerEffect(
        width: 300,
        height: 80,
      ),
    ); 
  }
}
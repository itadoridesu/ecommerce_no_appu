import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_vertical.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key, required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        shrinkWrap: true,
        
        children: [ Column(
          children: [
            
            // Brands
            const BrandShowcase(images: [TImages.productImage1, TImages.productImage2, TImages.productImage3]),
            
            const SizedBox(height: TSizes.spaceBtwItems,),
            
            SectionHeading(title: 'You might like', onPressed: () {},),
            
            const SizedBox(height: TSizes.spaceBtwItems,),
            
            GridLayout(itemCount: 4, itemBuilder: (_, index) => const ProductCardVertical(), mainAxisExtent: 288,),
            const SizedBox(height: TSizes.spaceBtwSections,)
          ],
        ),]
      ),
      );
  }
}
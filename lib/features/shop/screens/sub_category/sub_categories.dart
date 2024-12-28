import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/rounded_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_horizental.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  appBar: const CustomAppBar(
    title: Text('Sports'),
    showBackArrow: true,
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          /// Banner
          const RoundedImage(
            width: double.infinity,
            imageUrl: TImages.banner3,
            applyImageRadius: true,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          /// Sub-Categories
          Column(
            children: [
              /// Heading
              SectionHeading(
                title: 'Sports shirts',
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              SizedBox(
                height: 120,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) => const ProductCartHorizental(),
                  separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems,),
                  ),
              )
            ],
          ),
        ],
      ),
    ),
  ),
);

  }
}
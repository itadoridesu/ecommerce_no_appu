import 'package:ecommerce_no_shoppu/common/widgets/chips/choicu_chippu.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_title.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Selected Attribute Pricing & Description
        CircularContainer(
          radius: 16,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title, Price and Stock Status
              Row(
                children: [
                  const SectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    children: [
                      Row(
                        children: [
                          const ProductTitleText(
                              title: 'Price: ', smallSize: true),

                          /// Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ), // Text

                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const ProductPriceText(price: '20'),
                        ],
                      ),

                      // Stack
                      Row(
                        children: [
                          const ProductTitleText(
                              title: 'Stock', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const ProductTitleText(
                title:
                    'This is the Description of the Product and it can go up to max 4 lines.',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Colors Section
            const SectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                ChoicuChippu(
                    text: 'Green', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Blue', selected: true, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Green', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Blue', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Green', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Blue', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'Yellow', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Size Section
          children: [
            const SectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                ChoicuChippu(
                    text: 'EU 34', selected: true, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'EU 36', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'EU 38', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'EU 34', selected: true, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'EU 36', selected: false, onSelected: (value) {}),
                ChoicuChippu(
                    text: 'EU 38', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

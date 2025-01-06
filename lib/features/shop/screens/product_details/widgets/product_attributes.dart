import 'package:ecommerce_no_shoppu/common/widgets/chips/choicu_chippu.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_title.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/product_variation_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        children: [
          /// Selected Attribute Pricing & Description
          if (controller.selectedVariation.value.id.isNotEmpty)
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
                              if(controller.selectedVariation.value.salePrice > 0)
                              Text(
                                '\$${controller.getVariationPrice()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(decoration: TextDecoration.lineThrough),
                              ), // Text
      
                              const SizedBox(width: TSizes.spaceBtwItems),
      
                              /// Sale Price
                              ProductPriceText(price: controller.getVariationPrice()),
                            ],
                          ),
      
                          // Stack
                          Row(
                            children: [
                              const ProductTitleText(
                                  title: 'Stock', smallSize: true),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
      
                  /// Variation Description
                  ProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
      
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
      
          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: productModel.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                        
                            final available = controller
                                .getAttributesAvailabilityInVariation(productModel.productVariations!, attribute.name!)
                                .contains(attributeValue);
                        
                            return ChoicuChippu(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available ? (selected) {
                                if(selected && available) {
                                  controller.onAttributeSelected(productModel, attribute.name ?? '', attributeValue);
                                }
                              } : null
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/brand_title_with_verification.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_title.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/enums.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
  final dark = THelperFunctions.isDarkMode(context);
  final controller = ProductController.instance;
  final salesPercentage = controller.calculateSalePercentage(productModel.price, productModel.salePrice);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Price & Sale Price
      Row(
        children: [
          /// Sale Tag
          CircularContainer(
            radius: TSizes.sm,
            backgroundColor: TColors.secondary.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.sm,
              vertical: TSizes.xs,
            ),
            child: Text(
              '$salesPercentage%',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.black),
            ),
          ), // TRoundedContainer
          const SizedBox(width: TSizes.spaceBtwItems),

          /// Price
          if(productModel.productType == ProductType.single.toString() && productModel.salePrice > 0)
          Text('\$${controller.getProductPrice(productModel)}',style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough,),),
          if(productModel.productType == ProductType.single.toString() && productModel.salePrice > 0) 
          const SizedBox(width: TSizes.spaceBtwItems),

          /// Discounted Price
          ProductPriceText(price: controller.getProductPrice(productModel), isLarge: true),
        ],
      ), // Row
      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

      // Title
      ProductTitleText(title: productModel.title,),
      const SizedBox(height: TSizes.spaceBtwItems / 2,),

      // Stack Status
      Row(
        children: [
          const ProductTitleText(title: 'Status',),
          const SizedBox(width: TSizes.spaceBtwItems),
          Text(controller.getProductStockStatus(productModel.stock), style: Theme.of(context).textTheme.titleMedium,),

        ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 2,),

      // Brand
      Row(
        children: [
          CircularImage(
            image: TImages.clothIcon,
            height: 32,
            width: 32,
            overlayColor: dark ? TColors.white : TColors.black,
            ),
          BrandTitleWithVerification(title: productModel.brand != null ? productModel.brand!.name : '', brandTextSize: TextSizes.medium),
        ],
      )
    ],

  );
 }
}

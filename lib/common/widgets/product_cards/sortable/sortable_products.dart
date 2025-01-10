import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/product_cart_vertical.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/all_products_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key, required this.products
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(AllProductsController());
    controller.assigProducts(products);

    return Column(
      children: [
        /// Dropdown
        Obx(
          () => DropdownButtonFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
            ),
            dropdownColor: dark ? TColors.darkerGrey : TColors.grey,
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              controller.sortProducts(value!);
            },
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              'Newest',
              'Popularity'
             ].map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
          ),
        ), 
    
        const SizedBox(height: TSizes.spaceBtwSections),
    
        /// Products
        Obx(
          () => GridLayout(
            itemCount: controller.products.length, // Provide the total number of items
            itemBuilder: (_, index) => ProductCardVertical(productModel: controller.products[index],),
            mainAxisExtent: 288,
          ),
        ),
      ],
    );
  }
}
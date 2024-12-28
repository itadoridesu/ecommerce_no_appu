import 'package:ecommerce_no_shoppu/common/widgets/cart/add_remove.dart';
import 'package:ecommerce_no_shoppu/common/widgets/cart/cart_item.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key, this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Column(
            children: [
              const CartItem(),
              if(showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems,),

              if(showAddRemoveButtons) const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                     children: [
                       SizedBox(width: 70),
    
                       /// Add Remove Buttons
                       ProductQuantityWithAddRemove(),
                     ],
                   ),
                  ProductPriceText(price: '256.0',)
                ],
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemCount: 3);
  }
}

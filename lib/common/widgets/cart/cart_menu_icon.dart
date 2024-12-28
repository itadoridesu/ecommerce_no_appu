import 'package:ecommerce_no_shoppu/features/shop/screens/cart/cart.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartCountIcon extends StatelessWidget {
  const CartCountIcon({
    super.key, this.iconColor, //required this.onPressed
  });

  final Color? iconColor;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          )),
        Positioned(
          right: 0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color:  TColors.black.withOpacity(.8),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text('3', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white.withOpacity(.9), fontSizeFactor: 0.8)),
            ),
          )
          )
    ]);
  }
}
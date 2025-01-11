import 'package:ecommerce_no_shoppu/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/favorite_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Obx(() => CircularIcon(
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? TColors.error : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
        ));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/rounded_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/favorite_icon.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/image_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(productModel);

    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: TColors.primary,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: 24,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (context, index) => Obx(
                    () {
                      final imageSelected = controller.selectedProductImage.value == images[index];
                      return RoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                      imageUrl: images[index],
                      onPressed: () => controller.selectedProductImage.value = images[index],
                    );
                    } 
                  ),
                ),
              ),
            ),

            CustomAppBar(
              showBackArrow: true,
              actions: [
                FavoriteIcon(productId: productModel.id,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

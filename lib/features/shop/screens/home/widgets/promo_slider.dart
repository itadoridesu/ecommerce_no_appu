import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/rounded_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/banner_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      // Loader
      if (controller.isLoading.value) return const CustomShimmerEffect(width: double.infinity, height: 190);

      // No data found
      if (controller.banners.isEmpty) return const Center(child: Text('No data found'));

      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true, // Optionally enlarge the center image for a better effect
              onPageChanged: (index, _) => controller.updateImageIndicator(index),
              
            ),
            items: controller.banners
                .map((banner) => RoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    ))
                .toList(),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    CircularContainer(
                      width: 20,
                      height: 4,
                      backgroundColor: controller.carousalCurentIndex.value == i
                          ? TColors.primary
                          : TColors.grey,
                      margin: const EdgeInsets.only(right: 10),
                    )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}

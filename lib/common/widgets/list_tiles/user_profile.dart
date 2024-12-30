import 'package:ecommerce_no_shoppu/common/styles/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/user_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading Circular Image
          Obx(() {
            final networkImage = controller.user.value.profilePicture;
            final image = networkImage.isNotEmpty ? networkImage : TImages.user;
            return controller.imageUpoading.value
                ? const CustomShimmerEffect(
                    width: 80,
                    height: 80,
                    radius: 80,
                  )
                : ClipOval(
                    child: CircularImage(
                      image: image,
                      width: 70,
                      height: 70,
                      padding: 0,
                      isNetworkImage: networkImage.isNotEmpty,
                      fit: BoxFit.cover,
                    ),
                  );
          }),

          const SizedBox(width: 16), // Space between image and text content

          // Title and Subtitle (Full Name and Email)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                Obx(() {
                  if (controller.profileLoading.value) {
                    return const CustomShimmerEffect(width: 80, height: 15);
                  } else {
                    return Text(
                      controller.user.value.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: TColors.white),
                    );
                  }
                }),

                const SizedBox(height: 4), // Space between title and subtitle

                // Email
                Obx(() {
                  if (controller.profileLoading.value) {
                    return const CustomShimmerEffect(width: 120, height: 15);
                  } else {
                    return Text(
                      controller.user.value.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.white.withOpacity(.8)),
                    );
                  }
                }),
              ],
            ),
          ),

          // Trailing Edit Icon Button
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Iconsax.edit,
              color: TColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

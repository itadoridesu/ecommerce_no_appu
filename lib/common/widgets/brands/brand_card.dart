import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/images/circular_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/brand_title_with_verification.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/enums.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/helpers/helper_functions.dart';

class BrandCard extends StatelessWidget {
  /// Default constructor for the TBrandCard.
  ///
  /// Parameters:
  ///   - brand: The brand model to display.
  ///   - showBorder: A flag indicating whether to show a border around the card.
  ///   - onTap: Callback function when the card is tapped.
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      /// Container Design
      child: CircularContainer(
        radius: TSizes.cardRadiusLg,
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// -- Icon
            Flexible(
              child: CircularImage(
                image: TImages.clothIcon,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            /// -- Texts
            // [Expanded] & Column [MainAxisSize.min] is important to keep the elements in the vertical center and also
            // to keep text inside the boundaries.
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandTitleWithVerification(title: 'Nike', brandTextSize: TextSizes.large),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
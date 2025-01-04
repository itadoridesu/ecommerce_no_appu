import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/custom_shimmer_effect.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.height = 56,
    this.width = 56,
    this.padding = 8,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  final double height, width, padding;
  final Color? overlayColor, backgroundColor;
  final String image;
  final BoxFit? fit;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? TColors.black : TColors.white),
          shape: BoxShape.circle
          ),
      child: isNetworkImage
          ? CachedNetworkImage(
              fit: fit,
              color: overlayColor,
              imageUrl: image,
              progressIndicatorBuilder: (context, url, downloadProgress) => const CustomShimmerEffect(width: 55, height: 55, radius: 55,),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image(
              fit: fit,
              image: AssetImage(image),
              color: overlayColor,
            ),
    );
  }
}

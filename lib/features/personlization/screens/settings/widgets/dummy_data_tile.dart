import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DummyDataTile extends StatelessWidget {
  const DummyDataTile({
    super.key,
    required this.icon,
    this.onPressed,
    required this.title,
    this.padding = TSizes.spaceBtwItems,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String title;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Icon(
                  icon,
                  color: TColors.primary,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis, 
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.document_download),
            color: TColors.primary,
          ),
        ],
      ),
    );
  }
}

import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/cart/cart_menu_icon.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: TColors.grey)),
          Text('Dmdm hh',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: TColors.white)),
        ],
      ),
      actions: [
        CartCountIcon(
          iconColor: Colors.white.withOpacity(.9),
          // onPressed: () => Get.to(() => const CartScreen()),
        )
      ],
    );
  }
}
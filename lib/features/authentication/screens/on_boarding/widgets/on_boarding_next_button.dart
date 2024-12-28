import 'package:ecommerce_no_shoppu/features/authentication/controllers/onboarding/controllers_onboarding.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/device/device_utility.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() - 20,
      right: TSizes.defaultSpace,
        child: ElevatedButton(
            onPressed: () => OnBoardingController.instace.nextPage(),
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? TColors.primary : TColors.dark,
                side: BorderSide.none,
                ),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}

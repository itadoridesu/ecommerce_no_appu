import 'package:ecommerce_no_shoppu/features/authentication/controllers/onboarding/controllers_onboarding.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/device/device_utility.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingDotNavigation extends StatelessWidget {  
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instace;
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      left: TSizes.defaultSpace,
        child:
            SmoothPageIndicator(
              controller: controller.pageController, 
              onDotClicked: controller.dotNavigationClick,
              count: 3, 
              effect: ExpandingDotsEffect(
                activeDotColor: dark? TColors.light : TColors.dark, 
                dotHeight: 6),
                )
            );
  }
}
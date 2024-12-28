import 'package:ecommerce_no_shoppu/features/authentication/controllers/onboarding/controllers_onboarding.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/widgets/on_boarding_dot_navigation.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/widgets/on_boarding_next_button.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/widgets/on_boarding_page.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/on_boarding/widgets/on_boarding_skip.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [

          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              onBoardingPgae(
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
                image: TImages.onBoardingImage1,
              ),
              onBoardingPgae(
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
                image: TImages.onBoardingImage2,
              ),
              onBoardingPgae(
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
                image: TImages.onBoardingImage3,
              )
            ],
          ),

          const onBoardingSkip(),

          const onBoardingDotNavigation(),

          const onBoardingNextButton()
        ],
      ),
    );
  }
}



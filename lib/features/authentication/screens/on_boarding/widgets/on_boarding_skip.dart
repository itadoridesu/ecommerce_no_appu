import 'package:ecommerce_no_shoppu/features/authentication/controllers/onboarding/controllers_onboarding.dart';
import 'package:ecommerce_no_shoppu/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: 17,
        child: TextButton(
          onPressed: () => OnBoardingController.instace.skipPage(), 
          child: const Text('skip')));
  }
}

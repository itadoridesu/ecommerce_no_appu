import 'package:ecommerce_no_shoppu/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_no_shoppu/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/constants/text_strings.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // image
            Image.asset(
              TImages.deliveredEmailIllustration,
              width: THelperFunctions.screenWidth() * 0.6,
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Title and Subtitle
            Text(
              TTexts.confirmEmail,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            Text(
              email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            Text(
              TTexts.confirmEmailSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Buttons
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(TTexts.tContinue))),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => controller.sendEmailVerification(), child: const Text(TTexts.resendEmail))),
          ],
        ),
      ),
    );
  }
}

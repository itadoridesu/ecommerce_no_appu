import 'package:ecommerce_no_shoppu/common/styles/spacing_styles.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/login_signin_widgets/form_divider.dart';
import 'package:ecommerce_no_shoppu/common/widgets/login_signin_widgets/social_buttons.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/sign_up/widgets/sign_up_form.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/constants/text_strings.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          
              const SizedBox(height: TSizes.spaceBtwSections,),
          
              signUpForm(dark: dark),

              const SizedBox(height: TSizes.spaceBtwSections,),

              const formDivider(dividerText: TTexts.orSignUpWith),
          
              const SizedBox(height: TSizes.spaceBtwSections),
          
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}





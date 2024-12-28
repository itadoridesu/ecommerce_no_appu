import 'package:ecommerce_no_shoppu/common/styles/spacing_styles.dart';
import 'package:ecommerce_no_shoppu/common/widgets/login_signin_widgets/form_divider.dart';
import 'package:ecommerce_no_shoppu/common/widgets/login_signin_widgets/social_buttons.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce_no_shoppu/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/constants/text_strings.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: TSpacingStyles.paddingWithAppBarHeight,
        child: Column(
          children: [

            loginHeader(dark: dark),

            const SizedBox(height: TSizes.spaceBtwSections),

            const login_form(),

            const SizedBox(height: TSizes.spaceBtwSections),

            const formDivider(dividerText: TTexts.orSignInWith), // Row

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Footer
            const SocialButtons(),
          ],
        ),
      ),
    );
  }
}








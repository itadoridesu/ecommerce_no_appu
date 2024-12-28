import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/common/widgets/navigation_menu.dart';
import 'package:ecommerce_no_shoppu/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/cart/coupon_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const CartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
              const CouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              CircularContainer(
                radius: 16,
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    BillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Address Desu Yo
                    BillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(onPressed: () => Get.to(() => 
        SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: 'Payment Success',
          subTitle: 'Your item will be shipped soon insha\'Allah!',
          onPressed: () => Get.to(() => const NavigationMenu()),

        )),
         child: const Text('Continue \$256.0')),
      ),
    );
  }
}

import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Section Heading
      SectionHeading(
        title: 'Shipping Address',
        buttonTitle: 'Change',
        onPressed: () {},
      ),

      /// Name
      Text(
        'Dmdm hh',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 2),

      /// Phone Row
      Row(
        children: [
          const Icon(
            Icons.phone,
            color: Colors.grey,
            size: 16,
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          Text(
            '+213-794227879',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      const SizedBox(height: TSizes.spaceBtwItems / 2),

      /// Address Row
      Row(
        children: [
          const Icon(
            Icons.location_history,
            color: Colors.grey,
            size: 16,
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
          Expanded(
            child: Text(
              'Wakha sat, huzz bruzz, hhhh',
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
        ],
      ),
    ],
  );
}

}
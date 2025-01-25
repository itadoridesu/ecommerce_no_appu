import 'package:ecommerce_no_shoppu/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/address_controller.dart';
import 'package:ecommerce_no_shoppu/features/personlization/models/address_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, required this.onTap,});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      () { 
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return GestureDetector(
        onTap: onTap,
        child: CircularContainer(
          padding: const EdgeInsets.all(16),
          radius: 16,
          width: double.infinity,
          backgroundColor: selectedAddress
              ? TColors.primary.withOpacity(.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? TColors.darkGrey
                  : TColors.grey,
          showBorder: selectedAddress ? false : true,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 5,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? TColors.light
                          : TColors.dark.withOpacity(.6)
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ), // Text
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.phoneNumber.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TSizes.sm / 2),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );}
    );
  }
}

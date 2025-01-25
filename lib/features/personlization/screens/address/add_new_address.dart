import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/address_controller.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.addressFormKey,
            child: Column(
          children: [
            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('City', value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: controller.phoneNumber,
              validator: TValidator.validatePhoneNumber,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.street,
                    validator: (value) => TValidator.validateEmptyText('Street', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building_31),
                        labelText: 'Street'),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.postalCode,
                    validator: (value) => TValidator.validateEmptyText('Postal Code', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.code),
                        labelText: 'Postal Code'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) => TValidator.validateEmptyText('City', value),
                    controller: controller.city,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.building),
                      labelText: 'City',
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: controller.state,
                    validator: (value) => TValidator.validateEmptyText('State', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.activity),
                      labelText: 'State',
                    ),
                  ),
                ),
              ],
            ), // Row
            const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: controller.country,
              validator: (value) => TValidator.validateEmptyText('Country', value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.global),
                labelText: 'Country',
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addNewAddresses(), // Fixed missing function body
                child: const Text('Save'),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

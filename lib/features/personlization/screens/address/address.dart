import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/features/personlization/controllers/address_controller.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/address/add_new_address.dart';
import 'package:ecommerce_no_shoppu/features/personlization/screens/address/widgets/single_address.dart';
import 'package:ecommerce_no_shoppu/utils/constants/colors.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const AddNewAddress()),
          backgroundColor: TColors.primary,
          elevation: 0,
          child: const Icon(Iconsax.add, color: TColors.white,),
          
          ),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Obx(
          () => FutureBuilder(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {
          
               final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
               if(response != null) return response;
          
               final addresses = snapshot.data!;
          
               return ListView.builder(
                shrinkWrap: true,
                itemCount: addresses.length,
                itemBuilder:(_, index) => SingleAddress(
                address: addresses[index],
                onTap: () => controller.selectAddress(addresses[index])
                ),
               );
            }
          ),
        ),
      ),
    );
  }
}
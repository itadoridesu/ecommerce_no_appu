import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/sortable/sortable_products.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/brand_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brandModel});

  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(brandModel.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              BrandCard(showBorder: true, brand: brandModel),
              const SizedBox(height: TSizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId:  brandModel.id),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = VerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                    if (widget != null) return widget;

                    final brandProducts = snapshot.data!;
                    return SortableProducts(products: brandProducts);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

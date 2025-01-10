import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_card.dart';
import 'package:ecommerce_no_shoppu/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/brand_shimmer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/brand/brand_products.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const SectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Brands Grid
                        Obx(
                        () {

                          if(brandController.isLoading.value) return const BrandsShimmer(); 

                          if(brandController.allBrands.isEmpty) {
                            return Center(child: Text('No Data Found desu yo!', style: Theme.of(context).textTheme.bodyMedium,),);
                          }
                          
                          return GridLayout(
                            itemCount: brandController.allBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.allBrands[index];
                              return BrandCard(
                                brand: brand,
                                showBorder: true,
                                onTap: () => Get.to(() => BrandProducts(brandModel: brand,)),
                              );
                            });

                        } ,
                      )
            ],
          ),
        ),
      ),
    );
  }
}

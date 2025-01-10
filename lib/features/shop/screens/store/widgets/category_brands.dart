import 'package:ecommerce_no_shoppu/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/box_shimmer.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/category_model.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          /// Handle Loader, No Record, OR Error Message
          const loader = Column(
            children: [
              ListTileShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
              BoxShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
            ],
          ); // Column

          final widget = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot,
            loader: loader,
          );

          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];

                return FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {


                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                    if(widget != null) return widget;

                    final products = snapshot.data!;


                    return BrandShowcase(brand: brand, images: products.map( (product) => product.images).expand((images) => images ?? products.map((product) => product.thumbnail)).take(3).toList());
                  }
                );
              });
        });
  }
}

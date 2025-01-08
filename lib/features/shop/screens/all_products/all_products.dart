import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/sortable/sortable_products.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/product/all_products_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/models/product/product_model.dart';
import 'package:ecommerce_no_shoppu/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMehtod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMehtod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder(
              future: futureMehtod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                // Check the state of the futureBuilder snapshot
                const loader = VerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader); 
                
                if(widget != null) return widget;

                // If data is available, display the products
                final products = snapshot.data!;
                return SortableProducts(products: products,);
              }),
        ),
      ),
    );
  }
}

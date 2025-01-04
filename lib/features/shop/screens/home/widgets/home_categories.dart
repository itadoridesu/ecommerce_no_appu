import 'package:ecommerce_no_shoppu/common/widgets/image_text/category_widget.dart';
import 'package:ecommerce_no_shoppu/common/widgets/shimmers/category_shimmer.dart';
import 'package:ecommerce_no_shoppu/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/sub_category/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure GetX is imported

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(
      () {
        // Check if data is loading
        if (controller.isLoading.value) {
          return const CategoryShimmer();
        }

        // Check if there are no featured categories
        if (controller.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
            ),
          );
        }

        // If the list is not empty, return the category list
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredCategories.length,
            itemBuilder: (_, index) {
              final category = controller.featuredCategories[index];
              return CategoryWidget(
                image: category.image,
                title: category.name, 
                onTap: () => Get.to(() => const SubCategoriesScreen()),
              );
            },
          ),
        );
      },
    );
  }
}

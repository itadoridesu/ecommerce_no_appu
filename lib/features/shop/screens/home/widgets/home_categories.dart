import 'package:ecommerce_no_shoppu/common/widgets/image_text/category_widget.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/sub_category/sub_categories.dart';
import 'package:ecommerce_no_shoppu/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryWidget(
            image: TImages.shoeIcon, 
            title: 'shoeIcon', 
            onTap: () => Get.to(() => const SubCategoriesScreen()));
        }, 
        itemCount: 6
        ),
    );
  }
}


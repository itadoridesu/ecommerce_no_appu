import 'package:ecommerce_no_shoppu/common/widgets/app_bar/appbar.dart';
import 'package:ecommerce_no_shoppu/common/widgets/product_cards/ratings/ratings_bar_indicator.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_reviews/widgets/overall_rating.dart';
import 'package:ecommerce_no_shoppu/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:ecommerce_no_shoppu/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appu Baa
      appBar: const CustomAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),

      // Bodii desu
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ratings and reviews are verified and are more from people who use the same type of device that you use'),
              const SizedBox(height: TSizes.spaceBtwItems,),
              
              // Overall Product Ratings
              const OverAllProductRatingWidget(),
              const DmdmRatingBarIndicator(rating: 3.5),
              
              Padding(
                padding: const EdgeInsets.only(left: 6.0, top: 4),
                child: Text('12.611', style: Theme.of(context).textTheme.bodySmall,),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),


              // User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
          ),

      ),
    );
  }
}


import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:af_store/features/shop/screens/product_reviews/widget/rating_progress_indicator.dart';
import 'package:af_store/features/shop/screens/product_reviews/widget/user_review_card.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Reviews and Ratings are verified and are from people who use the same type of device that you are using.'),
              const SizedBox(
                height: FSizes.spaceBtwItems,
              ),

              //overall ratings
              const overAllProductRating(),
              //rating
              const FRatingBarIndicator(
                rating: 3.8,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: FSizes.spaceBtwSections,
              ),

              // user reviews list
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(FImages.user)),
                const SizedBox(
                  width: FSizes.spaceBtwItems,
                ),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          width: FSizes.spaceBtwItems,
        ),

        ///review
        Row(
          children: [
            const FRatingBarIndicator(rating: 4),
            const SizedBox(width: FSizes.spaceBtwItems),
            Text('04 June, 2024',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: FSizes.spaceBtwItems),
        const ReadMoreText(
          'This is a very good product. I love it.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: FColors.primaryColor),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: FColors.primaryColor),
        ),
        const SizedBox(
          height: FSizes.spaceBtwItems,
        ),
        FRoundedContainer(
          backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(FSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AF's Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      ' 01 Aug, 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const ReadMoreText(
                  'Thank you for your review. We are glad you liked our product. We hope to see you again soon.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: FColors.primaryColor),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: FColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: FSizes.spaceBtwSections,
        )
      ],
    );
  }
}

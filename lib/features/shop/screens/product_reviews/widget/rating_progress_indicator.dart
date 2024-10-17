import 'package:af_store/features/shop/screens/product_reviews/widget/progress_indicator.dart';
import 'package:flutter/material.dart';

class overAllProductRating extends StatelessWidget {
  const overAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              FRatingsIndicator(text: '5', value: 1.0),
              FRatingsIndicator(text: '4', value: 0.8),
              FRatingsIndicator(text: '3', value: 0.6),
              FRatingsIndicator(text: '2', value: 0.4),
              FRatingsIndicator(text: '1', value: 0.2),
            ],
          ),
        )
      ],
    );
  }
}

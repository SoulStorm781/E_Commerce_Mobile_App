import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/text/brand_title_verified.dart';
import 'package:af_store/common/widgets/text/product_title.dart';
import 'package:af_store/features/shop/models/cart_item_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FCartItemView extends StatelessWidget {
  const FCartItemView({
    super.key,
    required this.cartItem,
  });
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        ///Image
        FRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(FSizes.sm),
          backgroundColor: dark ? FColors.darkerGrey : FColors.light,
        ),
        const SizedBox(width: FSizes.spaceBtwItems),

        //title, price , sale price
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FBrandTitleVerified(title: cartItem.brandName ?? ''),
              Flexible(
                child: FProductTitle(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),
              //attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(children: [
                            TextSpan(
                                text: ' ${e.key} ',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${e.value} ',
                                style: Theme.of(context).textTheme.bodyLarge)
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

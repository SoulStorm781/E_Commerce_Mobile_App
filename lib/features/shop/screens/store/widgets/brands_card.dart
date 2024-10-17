import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/images/f_circular_image.dart';
import 'package:af_store/common/widgets/text/brand_title_verified.dart';
import 'package:af_store/features/shop/models/brand_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FBrandCards extends StatelessWidget {
  const FBrandCards({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });
  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: FRoundedContainer(
        padding: const EdgeInsets.all(FSizes.md),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            // brands icons
            Flexible(
              child: FCircularImage(
                isNetworkImage: true,
                image: brand.image,
                color: dark ? FColors.white : FColors.dark,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? FColors.white : FColors.dark,
              ),
            ),
            const SizedBox(width: FSizes.spaceBtwItems / 2),

            //textt

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FBrandTitleVerified(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

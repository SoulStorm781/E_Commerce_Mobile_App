import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/features/shop/models/brand_model.dart';
import 'package:af_store/features/shop/screens/brands/brand_products.dart';
import 'package:af_store/features/shop/screens/store/widgets/brands_card.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FBrandShowCase extends StatelessWidget {
  const FBrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });
  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    // final dark = FHelperFunnctions.isDarkMode(context);
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: FRoundedContainer(
        padding: const EdgeInsets.all(FSizes.md),
        showBorder: true,
        borderColor: FColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: FSizes.spaceBtwItems),
        child: Column(
          children: [
            FBrandCards(
              showBorder: false,
              brand: brand,
            ),

            //brand tap
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: FRoundedContainer(
          height: 100,
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.darkerGrey
              : FColors.light,
          margin: const EdgeInsets.only(right: FSizes.sm),
          padding: const EdgeInsets.all(FSizes.md),
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const FShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
    );
  }
}

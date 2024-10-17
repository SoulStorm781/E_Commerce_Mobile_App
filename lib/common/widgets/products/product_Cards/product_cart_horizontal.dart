import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/product_price_tag/productPriceTag.dart';
import 'package:af_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:af_store/common/widgets/text/brand_title_verified.dart';
import 'package:af_store/common/widgets/text/product_title.dart';
import 'package:af_store/features/shop/controllers/product/product_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FProductCardHorizontal extends StatelessWidget {
  const FProductCardHorizontal({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);

    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        // boxShadow: [FShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(
          FSizes.productImageRadius,
        ),
        color: dark ? FColors.darkerGrey : FColors.lightGrey,
      ),
      child: Row(
        children: [
          //thumbnail
          FRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(FSizes.sm),
            backgroundColor: dark ? FColors.dark : FColors.light,
            child: Stack(
              children: [
                //thumbnail image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: FRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                ),
                //sale tag
                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    child: FRoundedContainer(
                      radius: FSizes.sm,
                      backgroundColor: FColors.secondaryColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: FSizes.sm,
                        vertical: FSizes.xs,
                      ),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                              color: FColors.black,
                            ),
                      ),
                    ),
                  ),

                //favourite button
                Positioned(
                  top: 0,
                  right: 0,
                  child: FFavouriteIcon(productId: product.id),
                ),
              ],
            ),
          ),

          //Detail
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: FSizes.sm, left: FSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FProductTitle(
                        title: product.title,
                        smallSize: true,
                      ),
                      const SizedBox(height: FSizes.spaceBtwItems / 2),
                      FBrandTitleVerified(title: product.brand!.name)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Flexible(
                        child: Column(
                          children: [
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: FSizes.sm),
                                child: Text(product.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: FSizes.sm),
                              child: FProductPriceText(
                                price: controller.getProductPrice(product),
                                // price: '135',
                              ),
                            ),
                          ],
                        ),
                      ),
                      //add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: FColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(FSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              FSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: const SizedBox(
                          width: FSizes.iconLg * 1.1,
                          height: FSizes.iconLg * 1.1,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: FColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

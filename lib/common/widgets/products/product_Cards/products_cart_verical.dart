import 'package:af_store/common/styles/shadows.dart';
import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/product_price_tag/productPriceTag.dart';
import 'package:af_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:af_store/common/widgets/products_cart/add_to_cart_button.dart';
import 'package:af_store/common/widgets/text/brand_title_verified.dart';
import 'package:af_store/common/widgets/text/product_title.dart';
import 'package:af_store/features/shop/controllers/product/product_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/screens/product_details/product_detail.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FProductCardVertical extends StatelessWidget {
  const FProductCardVertical({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = FHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [FShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(
            FSizes.productImageRadius,
          ),
          color: FHelperFunctions.isDarkMode(context)
              ? FColors.darkGrey
              : FColors.white,
        ),
        child: Column(
          children: [
            //thumbnail, wishlist, discount
            FRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(FSizes.sm),
              backgroundColor: dark ? FColors.dark : FColors.light,
              child: Stack(
                children: [
                  //image
                  Center(
                    child: FRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  //sale tag
                  if (salePercentage != null)
                    Positioned(
                      top: 10,
                      child: FRoundedContainer(
                        radius: FSizes.md,
                        backgroundColor:
                            FColors.secondaryColor.withOpacity(0.8),
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
            const SizedBox(
              height: FSizes.spaceBtwItems / 2,
            ),
            // details

            Padding(
              padding: const EdgeInsets.only(left: FSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  FProductTitle(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: FSizes.spaceBtwItems / 2,
                  ),
                  FBrandTitleVerified(
                    title: product.brand?.name ?? '',
                  ),
                  // Spacer(),
                ],
              ),
            ),
            const Spacer(),

            //price row
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
                                    decoration: TextDecoration.lineThrough,
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
                ProductCartAddToCartButton(
                  product: product,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

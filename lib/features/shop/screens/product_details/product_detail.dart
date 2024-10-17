import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/screens/product_details/widget/bottom_add_to_cart.dart';
import 'package:af_store/features/shop/screens/product_details/widget/product_attributes.dart';
import 'package:af_store/features/shop/screens/product_details/widget/product_image_slider.dart';
import 'package:af_store/features/shop/screens/product_details/widget/product_metadata.dart';
import 'package:af_store/features/shop/screens/product_details/widget/rating.dart';
import 'package:af_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FBottomAddToCart(product: product),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //1- product image slider
              FProductImageSlider(
                product: product,
              ),

              //2-product details
              Padding(
                padding: const EdgeInsets.only(
                    right: FSizes.defaultSpace,
                    left: FSizes.defaultSpace,
                    bottom: FSizes.spaceBtwSections),
                child: Column(
                  children: [
                    //rating and share
                    const FRatingandShare(),

                    //price, title, stock, brand
                    FProductMetaData(
                      product: product,
                    ),

                    // Attributes
                    if (product.productType == ProductType.variable.toString())
                      FProductAttributes(
                        product: product,
                      ),
                    if (product.productType == ProductType.variable.toString())
                      const SizedBox(height: FSizes.spaceBtwSections),

                    //chekcout
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Checkout',
                            ))),
                    const SizedBox(height: FSizes.spaceBtwSections),

                    //description
                    const FSectionHeading(
                      title: 'Description',
                      showActionButtion: false,
                    ),
                    const SizedBox(height: FSizes.spaceBtwSections),
                    ReadMoreText(
                      product.description ?? '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show More',
                      trimExpandedText: 'Show Less',
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    //reviews
                    const Divider(),
                    const SizedBox(height: FSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FSectionHeading(
                          title: 'Reviews(199)',
                          showActionButtion: false,
                        ),
                        IconButton(
                            onPressed: () =>
                                Get.to(() => const ProductReviews()),
                            icon: const Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                            ))
                      ],
                    ),
                    const SizedBox(height: FSizes.spaceBtwSections),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

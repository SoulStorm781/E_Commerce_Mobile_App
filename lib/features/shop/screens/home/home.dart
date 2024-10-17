import 'package:af_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:af_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/products/product_Cards/products_cart_verical.dart';
import 'package:af_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/product/product_controller.dart';
import 'package:af_store/features/shop/screens/all_products/all_products.dart';
import 'package:af_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:af_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:af_store/features/shop/screens/home/widgets/promoslider.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //header
          const FPrimaryHeaderWidget(
            child: Column(
              children: [
                //appbar
                FHomeAppBar(),
                SizedBox(height: FSizes.spaceBtwSections),

                //search
                FSearchContainer(text: 'Search in Store'),
                SizedBox(height: FSizes.spaceBtwSections),

                //categories

                Padding(
                  padding: EdgeInsets.only(left: FSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //heading
                      FSectionHeading(
                        title: 'Popular Categories',
                        showActionButtion: false,
                        textColor: FColors.white,
                      ),
                      SizedBox(height: FSizes.spaceBtwItems),

                      //categories actual

                      FHomeCategories(),
                    ],
                  ),
                ),
                SizedBox(height: FSizes.spaceBtwSections),
              ],
            ),
          ),
          //body - promo images
          Padding(
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              children: [
                const FPromoSlider(),
                const SizedBox(
                  height: FSizes.spaceBtwSections,
                ),

                //heading
                FSectionHeading(
                  title: 'Popular Products',
                  onPressed: () => Get.to(() => AllProducts(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      )),
                ),
                const SizedBox(height: FSizes.spaceBtwItems),

                //product card
                Obx(() {
                  if (controller.isLoading.value) {
                    return const FVerticalProductShimmer();
                  }

                  if (controller.featuredProducts.isEmpty) {
                    return Center(
                        child: Text(
                      'No Products Here!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ));
                  }
                  return FGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => FProductCardVertical(
                          product: controller.featuredProducts[index]));
                }),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

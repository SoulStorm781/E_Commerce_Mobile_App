import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/products/product_Cards/products_cart_verical.dart';
import 'package:af_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/category_controller.dart';
import 'package:af_store/features/shop/models/category_model.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/screens/all_products/all_products.dart';
import 'package:af_store/features/shop/screens/store/widgets/category_brands.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCategoryTab extends StatelessWidget {
  const FCategoryTab(
      {super.key, required this.category, required this.product});
  final ProductModel product;
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              children: [
                ///brands
                CategoryBrands(category: category),

                const SizedBox(height: FSizes.spaceBtwItems),

                ///products
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      final response =
                          FCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const FVerticalProductShimmer());
                      if (response != null) return response;
                      final products = snapshot.data!;

                      return Column(
                        children: [
                          FSectionHeading(
                            title: 'You might like',
                            onPressed: () => Get.to(AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            )),
                          ),
                          const SizedBox(height: FSizes.spaceBtwItems),
                          FGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => FProductCardVertical(
                              product: products[index],
                            ),
                          ),
                        ],
                      );
                    }),

                ///
              ],
            ),
          ),
        ]);
  }
}

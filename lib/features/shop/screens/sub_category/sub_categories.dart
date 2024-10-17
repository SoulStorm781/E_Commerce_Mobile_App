import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/products/product_Cards/product_cart_horizontal.dart';
import 'package:af_store/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/category_controller.dart';
import 'package:af_store/features/shop/models/category_model.dart';
import 'package:af_store/features/shop/screens/all_products/all_products.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          category.name,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              const FRoundedImage(
                width: double.infinity,
                height: null,
                imageUrl: FImages.productbanner1,
                applyImageRadius: true,
              ),
              const SizedBox(height: FSizes.spaceBtwSections),

              // Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = FHorizontalProductShimmer();
                    final widget = FCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final subCategories = snapshot.data!;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                categoryId: subCategory.id,
                              ),
                              builder: (context, snapshot) {
                                //header, loader
                                final widget =
                                    FCloudHelperFunctions.checkMultiRecordState(
                                        snapshot: snapshot, loader: loader);
                                if (widget != null) return widget;

                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    //Heading
                                    FSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(() => AllProducts(
                                            title: subCategory.name,
                                            futureMethod:
                                                controller.getCategoryProducts(
                                                    categoryId: subCategory.id,
                                                    limit: -1),
                                          )),
                                    ),

                                    const SizedBox(
                                        height: FSizes.spaceBtwItems / 2),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                width: FSizes.spaceBtwItems),
                                        itemBuilder: (context, index) =>
                                            FProductCardHorizontal(
                                                product: products[index]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: FSizes.spaceBtwSections,
                                    )
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

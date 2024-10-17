import 'package:af_store/common/widgets/appbar/tab_bar.dart';
import 'package:af_store/common/widgets/shimmer/brand_shimmer.dart';
import 'package:af_store/features/shop/controllers/category_controller.dart';
import 'package:af_store/features/shop/controllers/product/brand_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/screens/brands/brand_products.dart';
import 'package:af_store/features/shop/screens/brands/all_brands.dart';
import 'package:af_store/features/shop/screens/store/widgets/brands_card.dart';
import 'package:af_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/products_cart/cart_menu_counter.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    //
    final dark = FHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: FAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            FCartCounterIcon(
              iconColor: dark ? FColors.white : FColors.dark,
              counterTextColor: dark ? FColors.dark : FColors.white,
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: FHelperFunctions.isDarkMode(context)
                      ? FColors.dark
                      : FColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(
                      FSizes.defaultSpace,
                    ),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        // search bar
                        const SizedBox(height: FSizes.spaceBtwItems),
                        const FSearchContainer(
                          text: 'Search in Store',
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: FSizes.spaceBtwSections),

                        // featured brands
                        FSectionHeading(
                          title: 'Featured Brands',
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen()),
                        ),

                        const SizedBox(
                          height: FSizes.spaceBtwItems / 1.5,
                        ),

                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const FBrandShimmer();
                          }

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No Brands Found',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }

                          return FGridLayout(
                            mainAxisExtent: 80,
                            itemCount: brandController.featuredBrands.length,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return FBrandCards(
                                showBorder: true,
                                brand: brand,
                                onTap: () =>
                                    Get.to(() => BrandProducts(brand: brand)),
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),

                  //tabs

                  bottom: FTabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList())),
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => FCategoryTab(
                        category: category,
                        product: ProductModel.empty(),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}

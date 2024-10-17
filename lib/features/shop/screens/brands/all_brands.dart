import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/shimmer/brand_shimmer.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/product/brand_controller.dart';
import 'package:af_store/features/shop/screens/brands/brand_products.dart';
import 'package:af_store/features/shop/screens/store/widgets/brands_card.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        appBar: const FAppBar(
          title: Text('Brands'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              FSizes.defaultSpace,
            ),
            child: Column(
              children: [
                //heading
                const FSectionHeading(
                  title: 'Brands',
                  showActionButtion: false,
                ),
                const SizedBox(height: FSizes.spaceBtwItems),

                //brands
                Obx(() {
                  if (controller.isLoading.value) return const FBrandShimmer();

                  if (controller.allBrands.isEmpty) {
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
                    itemCount: controller.allBrands.length,
                    itemBuilder: (_, index) {
                      final brand = controller.allBrands[index];
                      return FBrandCards(
                        showBorder: true,
                        brand: brand,
                        onTap: () => Get.to(() => BrandProducts(
                              brand: brand,
                            )),
                      );
                    },
                  );
                })
              ],
            ),
          ),
        ));
  }
}

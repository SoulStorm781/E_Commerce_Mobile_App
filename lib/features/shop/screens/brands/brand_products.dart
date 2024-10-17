import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:af_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:af_store/features/shop/controllers/product/brand_controller.dart';
import 'package:af_store/features/shop/models/brand_model.dart';
import 'package:af_store/features/shop/screens/store/widgets/brands_card.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({
    super.key,
    required this.brand,
  });
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final Logger logger = Logger();
    return Scaffold(
      appBar: FAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            children: [
              //Brand Detail
              FBrandCards(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(height: FSizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    //handle loader, no record, or error message
                    const loader = FVerticalProductShimmer();
                    final widget = FCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    return const FSortableProducts(
                      products: [],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

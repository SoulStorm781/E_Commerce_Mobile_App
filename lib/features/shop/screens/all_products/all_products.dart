import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:af_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:af_store/features/shop/controllers/allproduct_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';

import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: FAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductByQuery(query),
              builder: (context, snapshot) {
                //check the state of future builder
                const loader = FVerticalProductShimmer();

                final widget = FCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                final products = snapshot.data!;
                return FSortableProducts(
                  products: products,
                );
              }),
        ),
      ),
    );
  }
}

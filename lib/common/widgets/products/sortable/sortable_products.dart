import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/products/product_Cards/products_cart_verical.dart';
import 'package:af_store/features/shop/controllers/allproduct_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class FSortableProducts extends StatelessWidget {
  const FSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    logger.i(
        'Building ProductListWidget with product count: ${controller.products.length}');
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest']
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: FSizes.spaceBtwSections),

        ///Products
        Obx(() {
          return FGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => FProductCardVertical(
              product: controller.products[index],
            ),
          );
        }),
      ],
    );
  }
}

import 'package:af_store/common/widgets/chips/choice_chip.dart';
import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/product_price_tag/productPriceTag.dart';
import 'package:af_store/common/widgets/text/product_title.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/product/variation_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FProductAttributes extends StatelessWidget {
  const FProductAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = FHelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          //selected attributes and pricing
          if (controller.selectedVariation.value.id.isNotEmpty)
            FRoundedContainer(
              padding: const EdgeInsets.all(FSizes.md),
              backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
              child: Column(
                children: [
                  //title price and stock status
                  Row(
                    children: [
                      const FSectionHeading(
                          title: 'Variation', showActionButtion: false),
                      const SizedBox(width: FSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // actual price
                            children: [
                              const FProductTitle(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(width: FSizes.spaceBtwItems),
                              FProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),
                          // stock
                          Row(
                            children: [
                              const FProductTitle(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(controller.variationStockStatus.value,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // variation description
                  FProductTitle(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: FSizes.spaceBtwItems),

          // attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FSectionHeading(
                        title: attribute.name ?? '',
                        showActionButtion: false,
                      ),
                      const SizedBox(height: FSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((value) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    value;
                            final available = controller
                                .getAttributesAvailability(
                                    product.productVariations!, attribute.name!)
                                .contains(value);
                            return FChoiceChip(
                              text: value,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(product,
                                            attribute.name ?? '', value);
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

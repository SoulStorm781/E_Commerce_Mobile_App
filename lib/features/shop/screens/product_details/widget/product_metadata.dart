import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/images/f_circular_image.dart';
import 'package:af_store/common/widgets/product_price_tag/productPriceTag.dart';
import 'package:af_store/common/widgets/text/brand_title_verified.dart';
import 'package:af_store/common/widgets/text/product_title.dart';
import 'package:af_store/features/shop/controllers/product/product_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class FProductMetaData extends StatelessWidget {
  const FProductMetaData({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price, sale price
        Row(
          children: [
            //sale tag
            if (salePercentage != null)
              FRoundedContainer(
                radius: FSizes.md,
                backgroundColor: FColors.secondaryColor.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: FSizes.sm,
                  vertical: FSizes.xs,
                ),
                child: Text(
                  '$salePercentage%',
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: FColors.black,
                      ),
                ),
              ),

            const SizedBox(width: FSizes.defaultSpace),

            //price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text('\$${product.price}',
                  style: Theme.of(context).textTheme.titleSmall!.apply(
                        decoration: TextDecoration.lineThrough,
                      )),
            if (product.productType == ProductType.variable.toString() &&
                product.salePrice > 0)
              const SizedBox(width: FSizes.spaceBtwItems),
            FProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: FSizes.spaceBtwItems / 1.5),

        //title
        FProductTitle(title: product.title),
        const SizedBox(height: FSizes.spaceBtwItems / 1.5),
        //stock status
        Row(
          children: [
            const FProductTitle(title: 'Status:'),
            const SizedBox(width: FSizes.spaceBtwItems),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(height: FSizes.spaceBtwItems / 1.5),
        //brand
        Row(
          children: [
            FCircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: dark ? FColors.white : FColors.black,
            ),
            Expanded(
              child: FBrandTitleVerified(
                title: product.brand != null ? product.brand!.name : '',
                brandTextSize: TextSizes.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:af_store/common/widgets/icons/circular_icon.dart';
import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class FBottomAddToCart extends StatelessWidget {
  const FBottomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = FHelperFunctions.isDarkMode(context);
    final logger = Logger();

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: FSizes.defaultSpace, vertical: FSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? FColors.darkerGrey : FColors.light,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(FSizes.cardRadiusLg),
          topLeft: Radius.circular(FSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: FColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: FColors.white,
                  onPressed: () {
                    final cartItem = controller.convertToCartItem(
                        product, controller.productQuantityInCart.value);
                    controller.removeOneFromCart(cartItem); // Remove from cart
                    controller.updateAlreadyAddedProductCount(
                        product); // Update quantity
                  },
                ),
                const SizedBox(width: FSizes.spaceBtwItems),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: FSizes.spaceBtwItems),
                FCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: FColors.black,
                  width: 40,
                  height: 40,
                  color: FColors.white,
                  onPressed: () {
                    final cartItem = controller.convertToCartItem(product, 1);
                    controller.addOneToCart(cartItem); // Add to cart
                    controller.updateAlreadyAddedProductCount(
                        product); // Update quantity
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(FSizes.md),
                backgroundColor: FColors.black,
                side: const BorderSide(color: FColors.black),
              ),
              child: const Text('Add to Cart'),
            )
          ],
        ),
      ),
    );
  }
}

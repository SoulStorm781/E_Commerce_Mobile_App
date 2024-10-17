import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/screens/product_details/product_detail.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        //if the product have variations then show the products details for variations

        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
            color:
                productQuantityInCart > 0 ? FColors.primaryColor : FColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(FSizes.cardRadiusMd),
              bottomRight: Radius.circular(
                FSizes.productImageRadius,
              ),
            ),
          ),
          child: SizedBox(
            width: FSizes.iconLg * 1.1,
            height: FSizes.iconLg * 1.1,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: FColors.white),
                    )
                  : const Icon(
                      Iconsax.add,
                      color: FColors.white,
                    ),
            ),
          ),
        );
      }),
    );
  }
}

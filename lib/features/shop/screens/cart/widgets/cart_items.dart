import 'package:af_store/common/widgets/product_price_tag/productPriceTag.dart';
import 'package:af_store/common/widgets/products_cart/add_remove_button.dart';
import 'package:af_store/common/widgets/products_cart/cart_items_view.dart';
import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCartItems extends StatelessWidget {
  const FCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });
  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
          height: FSizes.spaceBtwSections,
        ),
        shrinkWrap: true,
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = controller.cartItems[index];
          return Column(
            children: [
              //cart item
              FCartItemView(
                cartItem: item,
              ),
              if (showAddRemoveButton)
                const SizedBox(height: FSizes.spaceBtwItems),

              //add remove button
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        //add and remove
                        FProductAddRemoveButton(
                          quantity: item.quantity,
                          add: () => controller.addOneToCart(item),
                          remove: () => controller.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    //total price
                    FProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1))
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}

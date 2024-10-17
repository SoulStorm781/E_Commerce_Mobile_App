import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/loaders/animation_loader.dart';
import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:af_store/features/shop/screens/checkout/checkout.dart';
import 'package:af_store/navigation_menu.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
// import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    // final dark = FHelperFunnctions.isDarkMode(context);
    return Scaffold(
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        final emptyWidget = FAnimationLoaderWidget(
          text: 'Whoops! Cart is Empty.',
          animation: FImages.emptycartAnimation,
          showAction: true,
          actionText: 'Let\'s Fill it.',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(FSizes.defaultSpace),

              //items in cart
              child: FCartItems(),
            ),
          );
        }
      }),

      //checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(FSizes.defaultSpace),
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(() =>
                      Text('Checkout \$${controller.totalCartPrice.value}'))),
            ),
    );
  }
}

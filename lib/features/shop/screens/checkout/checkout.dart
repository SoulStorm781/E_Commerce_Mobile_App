import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/products_cart/coupon_widget.dart';
import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/controllers/product/order_controller.dart';
import 'package:af_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:af_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:af_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:af_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:af_store/utils/helpers/pricing_calculator.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount =
        FPricingCalculator.calculateTotalPrice(subTotal, 'Pakistan');

    final dark = FHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            children: [
              const FCartItems(showAddRemoveButton: false),
              const SizedBox(height: FSizes.spaceBtwSections),

              //coupan field
              const FCouponCode(),
              const SizedBox(height: FSizes.spaceBtwSections),

              //billing Sections
              FRoundedContainer(
                padding: const EdgeInsetsDirectional.all(FSizes.md),
                showBorder: true,
                backgroundColor: dark ? FColors.black : FColors.white,
                child: const Column(
                  children: [
                    //Pricing
                    FBiliingAmountSection(),
                    SizedBox(height: FSizes.spaceBtwItems),
                    //Divider
                    Divider(),
                    SizedBox(height: FSizes.spaceBtwItems),
                    //Payments Methods
                    FBiliingPaymentSection(),
                    SizedBox(height: FSizes.spaceBtwItems),

                    //Address
                    FBilingAddresSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => FLoaders.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add items in the cart to proceed'),
            child: Text(
                'Checkout \$${FPricingCalculator.calculateTotalPrice(subTotal, 'Pakistan')}')),
      ),
    );
  }
}

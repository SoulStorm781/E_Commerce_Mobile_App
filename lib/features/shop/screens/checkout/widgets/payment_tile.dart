import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:af_store/features/shop/models/payment_method_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FPaymentTile extends StatelessWidget {
  const FPaymentTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: FRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: FHelperFunctions.isDarkMode(context)
            ? FColors.light
            : FColors.white,
        padding: const EdgeInsets.all(FSizes.sm),
        child:
            Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}

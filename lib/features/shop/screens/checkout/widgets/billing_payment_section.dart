import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FBiliingPaymentSection extends StatelessWidget {
  const FBiliingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;

    final dark = FHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        FSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: FSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              FRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? FColors.light : FColors.white,
                padding: const EdgeInsets.all(FSizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPaymentMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: FSizes.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

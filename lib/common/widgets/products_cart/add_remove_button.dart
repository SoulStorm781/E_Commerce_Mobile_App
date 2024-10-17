import 'package:af_store/common/widgets/icons/circular_icon.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FProductAddRemoveButton extends StatelessWidget {
  const FProductAddRemoveButton({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });
  final int quantity;
  final VoidCallback add, remove;
  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FCircularIcon(
          onPressed: remove,
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: FSizes.md,
          color: dark ? FColors.white : FColors.black,
          backgroundColor: dark ? FColors.darkerGrey : FColors.light,
        ),
        const SizedBox(width: FSizes.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: FSizes.spaceBtwItems),
        FCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: FSizes.md,
          color: FColors.white,
          backgroundColor: FColors.primaryColor,
          onPressed: add,
        ),
      ],
    );
  }
}

import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FRatingandShare extends StatelessWidget {
  const FRatingandShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //rating
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: FSizes.defaultSpace / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '5.0',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const TextSpan(text: '(104)')
                ],
              ),
            ),
          ],
        ),
        //share
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: FSizes.iconMd,
            ))
      ],
    );
  }
}

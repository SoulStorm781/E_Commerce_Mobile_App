import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FVerticalProductShimmer extends StatelessWidget {
  const FVerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return FGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 100,
        child: Column(
          children: [
            //image
            FShimmerEffect(width: 180, height: 180),
            SizedBox(height: FSizes.spaceBtwItems),

            //text
            FShimmerEffect(width: 160, height: 15),
            SizedBox(height: FSizes.spaceBtwItems / 2),
            FShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}

import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FCategoryShimmer extends StatelessWidget {
  const FCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(
                width: FSizes.spaceBtwItems,
              ),
          itemCount: itemCount,
          itemBuilder: (_, __) => const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  FShimmerEffect(
                    width: 55,
                    height: 55,
                    radius: 55,
                  ),
                  SizedBox(height: FSizes.spaceBtwItems / 2),

                  //text

                  FShimmerEffect(width: 55, height: 8),
                ],
              )),
    );
  }
}

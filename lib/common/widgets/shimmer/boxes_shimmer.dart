import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/widgets.dart';

class FBoxesShimmer extends StatelessWidget {
  const FBoxesShimmer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: FShimmerEffect(width: 150, height: 110)),
            SizedBox(height: FSizes.spaceBtwItems),
            Expanded(child: FShimmerEffect(width: 150, height: 110)),
            SizedBox(height: FSizes.spaceBtwItems),
            Expanded(child: FShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}

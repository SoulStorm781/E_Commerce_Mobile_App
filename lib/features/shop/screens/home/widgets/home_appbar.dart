import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/products_cart/cart_menu_counter.dart';
import 'package:af_store/features/personalization/controllers/user_controller.dart';
import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FHomeAppBar extends StatelessWidget {
  const FHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return FAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            FTexts.homeTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: FColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const FShimmerEffect(width: 100, height: 15);
            }
            return Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: FColors.white),
            );
          }),
        ],
      ),
      actions: const [
        FCartCounterIcon(
          iconColor: FColors.white,
          counterTextColor: FColors.white,
          counterbgColor: FColors.black,
        ),
      ],
    );
  }
}

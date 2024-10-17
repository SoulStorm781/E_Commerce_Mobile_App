import 'package:af_store/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/features/shop/controllers/banner_controller.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FPromoSlider extends StatelessWidget {
  const FPromoSlider({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const FShimmerEffect(width: double.infinity, height: 198);
      }
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text('Data Not Found'),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                ),
                items: controller.banners
                    .map((banner) => FRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          applyImageRadius: true,
                          fit: BoxFit.cover,
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ))
                    .toList()),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    FCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carousalCurrentIndex.value == i
                              ? FColors.primaryColor
                              : FColors.grey,
                    ),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}

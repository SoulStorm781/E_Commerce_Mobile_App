import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:af_store/common/widgets/images/f_rounded_images.dart';
import 'package:af_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:af_store/features/shop/controllers/product/images_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FProductImageSlider extends StatelessWidget {
  const FProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final image = controller.getAllProductImages(product);

    final dark = FHelperFunctions.isDarkMode(context);
    return FCurvedEdges(
      child: Container(
        color: dark ? FColors.darkerGrey : FColors.light,
        child: Stack(
          children: [
            //main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(FSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: FColors.primaryColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            //image slider

            Positioned(
              right: 0,
              bottom: 30,
              left: FSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    width: FSizes.spaceBtwItems,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: image.length,
                  itemBuilder: (_, index) => Obx(() {
                    final imagesSelected =
                        controller.selectedProductImage.value == image[index];
                    return FRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      onPressed: () =>
                          controller.selectedProductImage.value = image[index],
                      imageUrl: image[index],
                      backgroundColor: dark ? FColors.dark : FColors.white,
                      border: Border.all(
                          color: imagesSelected
                              ? FColors.primaryColor
                              : Colors.transparent),
                      padding: const EdgeInsets.all(FSizes.sm),
                    );
                  }),
                ),
              ),
            ),

            //apppbar icon
            FAppBar(
              showBackArrow: true,
              actions: [
                FFavouriteIcon(
                  productId: product.id,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

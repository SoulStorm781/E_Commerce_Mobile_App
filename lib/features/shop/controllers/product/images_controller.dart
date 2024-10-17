import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  //variable
  final isLoading = false.obs;
  RxString selectedProductImage = ''.obs;

  //get all image sfrom product and variations
  List<String> getAllProductImages(ProductModel product) {
    //use set to add unique images only even same image with diffrent url will not ork
    Set<String> images = {};

    //load thumbnail image
    images.add(product.thumbnail);

    //assign thumnail a sselected image
    selectedProductImage.value = product.thumbnail;

    //get all images from the product model
    if (product.images != null) {
      images.addAll(product.images!);
    }

    //get all the iamges from the product  variation
    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  //show enlarged images
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: FSizes.defaultSpace * 2,
                        horizontal: FSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(
                    height: FSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Back')),
                    ),
                  ),
                ],
              ),
            ));
  }
}

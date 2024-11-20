import 'package:af_store/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:af_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:af_store/features/shop/controllers/category_controller.dart';

import 'package:af_store/features/shop/screens/sub_category/sub_categories.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FHomeCategories extends StatelessWidget {
  const FHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const FCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Founds!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return FVerticalImageText(
              isNetworkImage: true,
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => SubCategories(category: category)),
            );
          },
        ),
      );
    });
  }
}

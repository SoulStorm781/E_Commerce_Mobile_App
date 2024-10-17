import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/icons/circular_icon.dart';
import 'package:af_store/common/widgets/layout/grid_layout.dart';
import 'package:af_store/common/widgets/loaders/animation_loader.dart';
import 'package:af_store/common/widgets/products/product_Cards/products_cart_verical.dart';
import 'package:af_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:af_store/features/shop/controllers/product/favourite_controller.dart';
import 'package:af_store/features/shop/screens/home/home.dart';
import 'package:af_store/navigation_menu.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          FCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(
              const HomeScreen(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            FSizes.defaultSpace,
          ),

          //grid layout
          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  //nothing found widget
                  final emptyWidget = FAnimationLoaderWidget(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: FImages.emptywishlist,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () =>
                        Get.off(() => const NavigationMenu()),
                  );

                  const loader = FVerticalProductShimmer(
                    itemCount: 6,
                  );
                  final widget = FCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  return FGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        FProductCardVertical(product: products[index]),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

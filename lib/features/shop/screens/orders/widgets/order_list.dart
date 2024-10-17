import 'package:af_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:af_store/common/widgets/loaders/animation_loader.dart';
import 'package:af_store/features/shop/controllers/product/order_controller.dart';
import 'package:af_store/navigation_menu.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FOrderListItems extends StatelessWidget {
  const FOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = FHelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          //nothing found widget
          final emptyWidget = FAnimationLoaderWidget(
            text: 'Whoops!, No Orders Yet!',
            animation: FImages.emptyorder,
            showAction: true,
            actionText: 'Let\'s Shop',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          //helper function to handle loader
          final response = FCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          //congrats record found
          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, index) =>
                  const SizedBox(height: FSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return FRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(FSizes.md),
                  backgroundColor: dark ? FColors.dark : FColors.light,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      //row 1
                      Row(
                        children: [
                          //1- Icon
                          const Icon(Iconsax.ship),
                          const SizedBox(width: FSizes.spaceBtwItems / 2),

                          //2- status and date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: FColors.primaryColor,
                                          fontWeightDelta: 1),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              ],
                            ),
                          ),
                          // 3- icon

                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.arrow_right_34,
                                size: FSizes.iconSm,
                              ))
                        ],
                      ),
                      const SizedBox(height: FSizes.spaceBtwItems),

                      //row 2
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                //1- Icon
                                const Icon(Iconsax.tag),
                                const SizedBox(width: FSizes.spaceBtwItems / 2),

                                //2- status and date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.id,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                //1- Icon
                                const Icon(Iconsax.calendar),
                                const SizedBox(width: FSizes.spaceBtwItems / 2),

                                //2- status and date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping Date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.formattedDeliveryDate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }
}

import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:af_store/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:af_store/common/widgets/list_tile/user_profile_tile.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/features/personalization/screens/address/address.dart';
import 'package:af_store/features/personalization/screens/profile/profile.dart';
import 'package:af_store/features/shop/screens/cart/cart.dart';
import 'package:af_store/features/shop/screens/orders/order.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header
            FPrimaryHeaderWidget(
              child: Column(
                children: [
                  FAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: FColors.white),
                    ),
                  ),
                  FUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: FSizes.spaceBtwSections),
                ],
              ),
            ),

            ///body
            Padding(
              padding: const EdgeInsets.all(FSizes.defaultSpace),
              child: Column(
                children: [
                  const FSectionHeading(
                    title: 'Account Settings',
                    showActionButtion: false,
                  ),
                  const SizedBox(height: FSizes.spaceBtwItems),
                  FSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subtitle: 'Set Shopping delivery address',
                    OnTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                    OnTap: () => Get.to(const CartScreen()),
                  ),
                  FSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      OnTap: () => Get.to(() => const OrderScreen()),
                      title: 'My Orders',
                      subtitle: 'In-progress and Completed Orders'),
                  const FSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subtitle: 'Withdraw and Deposit Money'),
                  const FSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subtitle: 'List of all Discount Coupons'),
                  const FSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subtitle: 'Set Any kind of Notifications'),
                  const FSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subtitle: 'Manage data usage and connected accounts'),

                  // app setting
                  const SizedBox(height: FSizes.spaceBtwSections),

                  const FSectionHeading(
                      title: 'App Settings', showActionButtion: false),

                  const SizedBox(height: FSizes.spaceBtwItems),

                  FSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subtitle: 'Uplaod Data to your Cloud Firebase',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geo Location',
                    subtitle: 'Set recommendations based on location',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  FSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search Result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  FSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),

                  //logout button
                  const SizedBox(height: FSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => controller.logout(),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: FSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

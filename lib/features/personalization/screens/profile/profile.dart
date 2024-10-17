import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/common/widgets/images/f_circular_image.dart';
import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/personalization/controllers/user_controller.dart';
import 'package:af_store/features/personalization/screens/profile/widget/change_name.dart';
import 'package:af_store/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:af_store/common/widgets/shimmer/shimmer.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const FAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: Column(
          children: [
            //profile pic
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image =
                        networkImage.isNotEmpty ? networkImage : FImages.user;

                    return controller.imageUploading.value
                        ? const FShimmerEffect(
                            width: 80,
                            height: 80,
                            radius: 80,
                          )
                        : FCircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty,
                          );
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'))
                ],
              ),
            ),
            // detail

            const SizedBox(
              height: FSizes.spaceBtwItems / 2,
            ),
            const Divider(),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),

            // heading profile info
            const FSectionHeading(
              title: 'Profile Information',
              showActionButtion: false,
            ),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),
            FProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const changeName())),
            FProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {}),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),
            const Divider(),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),

            //personal information
            const FSectionHeading(
              title: 'Personal Information',
              showActionButtion: false,
            ),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),
            FProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {}),
            FProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {}),
            FProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () {}),
            FProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
            FProfileMenu(
                title: 'Date of Birth',
                value: '06 June, 2002',
                onPressed: () {}),
            const Divider(),
            const SizedBox(
              height: FSizes.spaceBtwItems,
            ),

            Center(
              child: TextButton(
                onPressed: () => controller.deleteAccountWarningPopup(),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:af_store/common/styles/spacing_styles.dart';
import 'package:af_store/features/authentication/controllers/forget_password/forget_pass_controller.dart';
import 'package:af_store/features/authentication/screens/login/login.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class resetPassword extends StatelessWidget {
  const resetPassword({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(
              CupertinoIcons.clear,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: FSpacingStyle.paddingwithAppBarHeight * 2,
          child: Column(
            children: [
              //image
              Image(
                image: const AssetImage(FImages.continueshop),
                width: FHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: FSizes.spaceBtwSections,
              ),
              //title and description
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                FTexts.changePasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: FSizes.spaceBtwItems,
              ),
              Text(
                FTexts.changePasswordSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: FSizes.spaceBtwItems,
              ),

              //button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(FTexts.fDone),
                ),
              ),
              const SizedBox(
                height: FSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance
                      .resendPasswordResetEmail(email),
                  child: const Text(FTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

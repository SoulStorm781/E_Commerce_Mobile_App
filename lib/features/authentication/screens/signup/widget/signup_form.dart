import 'package:af_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:af_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FSignupForm extends StatelessWidget {
  const FSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final dark = FHelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //name fields
          Row(
            children: [
              Expanded(
                //first name
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      FValidator.validateEmpty('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: FTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: FSizes.spaceBtwInputFields,
              ),
              Expanded(
                //second name
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      FValidator.validateEmpty('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: FTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: FSizes.spaceBtwInputFields,
          ),
          //username
          TextFormField(
            controller: controller.username,
            validator: (value) => FValidator.validateEmpty('Username', value),
            decoration: const InputDecoration(
              labelText: FTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          const SizedBox(
            height: FSizes.spaceBtwInputFields,
          ),

          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => FValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: FTexts.email,
              prefixIcon: Icon(Icons.email),
            ),
          ),

          const SizedBox(
            height: FSizes.spaceBtwInputFields,
          ),

          //phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => FValidator.validatephoneNumber(value),
            decoration: const InputDecoration(
              labelText: FTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          const SizedBox(
            height: FSizes.spaceBtwInputFields,
          ),

          //password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => FValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: FTexts.password,
                prefixIcon: const Icon(Iconsax.key),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),

          const SizedBox(
            height: FSizes.spaceBtwInputFields,
          ),

          //terms and conditions
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Obx(
                  () => Checkbox(
                      value: controller.privacyPolicy.value,
                      onChanged: (value) => controller.privacyPolicy.value =
                          !controller.privacyPolicy.value),
                ),
              ),
              const SizedBox(width: FSizes.spaceBtwItems),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: FTexts.iAgreeto,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' ${FTexts.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? FColors.white : FColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? FColors.white : FColors.primaryColor,
                          ),
                    ),
                    TextSpan(
                      text: FTexts.and,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: ' ${FTexts.termsofuse}',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: dark ? FColors.white : FColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                dark ? FColors.white : FColors.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: FSizes.spaceBtwSections,
          ),
          //sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(FTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

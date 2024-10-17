import 'package:af_store/features/personalization/controllers/user_controller.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: FValidator.validateEmail,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: FTexts.email),
                  ),
                  const SizedBox(
                    height: FSizes.spaceBtwInputFields,
                  ),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          FValidator.validateEmpty('Password', value),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: const Icon(Iconsax.eye_slash)),
                          labelText: FTexts.password),
                    ),
                  ),
                  const SizedBox(
                    height: FSizes.spaceBtwSections,
                  ),

                  //llogin button

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailandPassword(),
                      child: const Text('Verify'),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

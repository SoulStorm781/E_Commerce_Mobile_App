import 'package:af_store/features/authentication/controllers/login/login_controller.dart';
import 'package:af_store/features/authentication/screens/signup/signup.dart';
import 'package:af_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FLoginForm extends StatelessWidget {
  const FLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: FSizes.spaceBtwItems),
        child: Column(
          children: [
            //Email
            TextFormField(
              controller: controller.email,
              validator: (value) => FValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: FTexts.email,
              ),
            ),
            const SizedBox(height: FSizes.spaceBtwInputFields),
            //password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    FValidator.validateEmpty('Password', value),
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
            const SizedBox(height: FSizes.spaceBtwInputFields / 2),
            //Remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberME.value,
                          onChanged: (value) => controller.rememberME.value =
                              !controller.rememberME.value),
                    ),
                    const Text(FTexts.rememberMe),
                  ],
                ),

                //forget password
                TextButton(
                  onPressed: () => Get.to(() => const forgetPassword()),
                  child: const Text(FTexts.forgotPassword),
                ),
              ],
            ),
            const SizedBox(height: FSizes.spaceBtwSections),

            //Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.loginWithEmailAndPassword(),
                child: const Text(FTexts.signIn),
              ),
            ),
            const SizedBox(height: FSizes.spaceBtwSections),

            //create account
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(FTexts.createAccount),
              ),
            ),
            const SizedBox(height: FSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}

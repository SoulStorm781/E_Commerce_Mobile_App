import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/features/personalization/controllers/updatename_controller.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class changeName extends StatelessWidget {
  const changeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      //custom appbar
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(FSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //headings
            Text(
              'Use Real name foeasy verification. This name will appear onseveral pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: FSizes.spaceBtwSections),
            // Form input and buttons
            Form(
              key: controller.updateUserNameformKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        FValidator.validateEmpty('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: FTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: FSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        FValidator.validateEmpty('Last Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: FTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: FSizes.spaceBtwSections),

            //save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/features/personalization/controllers/address_controller.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: const FAppBar(
          showBackArrow: true,
          title: Text(
            'Add New Address',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            FSizes.defaultSpace,
          ),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    controller: controller.name,
                    validator: (value) =>
                        FValidator.validateEmpty('Name', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: 'Name',
                    )),
                const SizedBox(height: FSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.phoneNumber,
                    validator: FValidator.validatephoneNumber,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone Number',
                    )),
                const SizedBox(height: FSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.street,
                          validator: (value) =>
                              FValidator.validateEmpty('Street', value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street',
                          )),
                    ),
                    const SizedBox(width: FSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) =>
                              FValidator.validateEmpty('Postal Code', value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Postal Code',
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: FSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.city,
                          validator: (value) =>
                              FValidator.validateEmpty('City', value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City',
                          )),
                    ),
                    const SizedBox(width: FSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                          controller: controller.state,
                          validator: (value) =>
                              FValidator.validateEmpty('State', value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State',
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: FSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.country,
                    validator: (value) =>
                        FValidator.validateEmpty('Country', value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global),
                      labelText: 'Country',
                    )),
                const SizedBox(height: FSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addNewAddreses(),
                      child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

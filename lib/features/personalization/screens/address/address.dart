import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/features/personalization/controllers/address_controller.dart';
import 'package:af_store/features/personalization/screens/address/add_new_address.dart';
import 'package:af_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:af_store/utils/constants/colors.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: FColors.primaryColor,
        child: const Icon(Iconsax.add, color: FColors.white),
      ),
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(

                //user key t trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  //helper function, handle error , no record loader
                  final response = FCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (response != null) return response;

                  final addresses = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (_, index) => FSingleAddress(
                      address: addresses[index],
                      onTap: () {
                        controller.selectAddress(addresses[index]);
                      },
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/data/repositories/address/address_repository.dart';
import 'package:af_store/features/personalization/models/address_model.dart';
import 'package:af_store/features/personalization/screens/address/add_new_address.dart';
import 'package:af_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:af_store/utils/helpers/cloud_helper_functions.dart';
import 'package:af_store/utils/helpers/network_manager.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  //fetch all user specific address
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      FLoaders.errorSnackBar(title: 'Address not Found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      //clear the already selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      //assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //set the selected field to true
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      FLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

//----------------------add new address----------------------------
  Future addNewAddreses() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog('Storing Address', FImages.process);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!addressFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //save address

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      //update selecred address status
      address.id = id;
      await selectAddress(address);

      //remove loader
      FFullScreenLoader.stopLoading();

      //show success message
      FLoaders.successSnackBar(
          title: 'Congrats!', message: 'Address has been added successfully.');

      refreshData.toggle();

      resetFormField();

      //redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      FLoaders.errorSnackBar(
          title: 'Error in Adding Address', message: e.toString());
    }
  }

//----------------------show addresses modalbottomsheet at checkout---------
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(FSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FSectionHeading(
                    title: 'Select Address',
                    showActionButtion: false,
                  ),
                  FutureBuilder(
                    future: getAllUserAddresses(),
                    builder: (_, snapshot) {
                      final response =
                          FCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => FSingleAddress(
                          address: snapshot.data![index],
                          onTap: () async {
                            selectedAddress(snapshot.data![index]);
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: FSizes.defaultSpace * 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const AddNewAddressScreen()),
                        child: const Text('Add New Address')),
                  ),
                ],
              ),
            ));
  }

  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();
    country.clear();
    addressFormKey.currentState!.reset();
  }
}

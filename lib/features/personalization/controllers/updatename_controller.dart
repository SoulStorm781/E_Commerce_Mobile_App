import 'package:af_store/data/repositories/user/user_repository.dart';
import 'package:af_store/features/personalization/controllers/user_controller.dart';
import 'package:af_store/features/personalization/screens/profile/profile.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/helpers/network_manager.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameformKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog(
          'We are updating your information....', FImages.process);
      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // from validation
      if (!updateUserNameformKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //update user's first and last name in firestore
      Map<String, dynamic> name = {
        'First Name': firstName.text.trim(),
        'Last Name': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);
      // update the rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      FFullScreenLoader.stopLoading();

      //show success message
      FLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Name has been updated successfully');
      // move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FFullScreenLoader.stopLoading();
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

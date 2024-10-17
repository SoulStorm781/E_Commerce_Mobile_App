import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/helpers/network_manager.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', FImages.process);
      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      FFullScreenLoader.stopLoading();
      //show succes screen
      FLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link is sent to reset your password.');

      //redirect
      Get.to(() => resetPassword(email: email.text.trim()));
    } catch (e) {
      //remove loader
      FFullScreenLoader.stopLoading();
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', FImages.process);
      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      FFullScreenLoader.stopLoading();
      //show succes screen
      FLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Is Sent To Reset Your Password.');
    } catch (e) {
      //remove loader
      FFullScreenLoader.stopLoading();
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

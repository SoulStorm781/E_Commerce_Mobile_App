import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/data/repositories/user/user_repository.dart';
import 'package:af_store/features/authentication/screens/signup/verify_email.dart';
import 'package:af_store/features/personalization/models/user_model.dart';
import 'package:af_store/utils/helpers/network_manager.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  //---Signup
  void signup() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog(
          'We are processing your information...', FImages.process);
      //check intenet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      // privacy policy check
      if (!privacyPolicy.value) {
        FLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must accept our privacy policy & Terms of use.',
        );
        return;
      }

      // register userin firebase authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      // save user data in firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        username: username.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FFullScreenLoader.stopLoading();

      // show success message
      FLoaders.successSnackBar(
          title: 'Congratulations!',
          message:
              'Your Account has been created successfully. Please verify your email address to login.');
      //send email verification
      Get.to(() => verifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      FFullScreenLoader.stopLoading();
      //handle error
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

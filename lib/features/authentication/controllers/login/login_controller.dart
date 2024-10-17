import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/features/personalization/controllers/user_controller.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/helpers/network_manager.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  // variable
  final rememberME = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //email password login
  Future<void> loginWithEmailAndPassword() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog('Loggin you in...', FImages.process);
      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!loginFormKey.currentState!.validate()) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is checked
      if (rememberME.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //login using email and password
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      FFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FFullScreenLoader.stopLoading();
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //login with google
  Future<void> loginWithGoogle() async {
    try {
      //start loading
      FFullScreenLoader.openLoadingDialog('Loggin you in...', FImages.process);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FFullScreenLoader.stopLoading();
        return;
      }

      //login using google
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      //store in firestore
      await userController.saveUserRecord(userCredentials);

      //rmove loader
      FFullScreenLoader.stopLoading();

      //redirect

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

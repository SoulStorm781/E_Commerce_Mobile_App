import 'dart:async';
import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/features/authentication/screens/signup/success_screen.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/text_strings.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //send email verify link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      FLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your inbox and verify your email.',
      );
    } catch (e) {
      FLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // check if email is verified
      await FirebaseAuth.instance.currentUser?.reload();
      // if verified, redirect to login
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: FImages.continueshop,
            title: FTexts.yourAccountCreated,
            subtitle: FTexts.yourAccountCreatedSubtitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
      // if not verified, keep checking
    });
  }

  // manually check if email verifies
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: FImages.continueshop,
          title: FTexts.yourAccountCreated,
          subtitle: FTexts.yourAccountCreatedSubtitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}

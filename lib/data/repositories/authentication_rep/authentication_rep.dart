import 'package:af_store/data/repositories/user/user_repository.dart';
import 'package:af_store/features/authentication/screens/login/login.dart';
import 'package:af_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:af_store/features/authentication/screens/signup/verify_email.dart';
import 'package:af_store/navigation_menu.dart';
import 'package:af_store/utils/exception/firebase_auth_exceptions.dart';
import 'package:af_store/utils/exception/firebase_exceptions.dart';
import 'package:af_store/utils/exception/format_exceptions.dart';
import 'package:af_store/utils/exception/platform_exceptions.dart';
import 'package:af_store/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get auth user data
  User get authUser => _auth.currentUser!;

  //called from main.dart on an appp start
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //function to show relevant screen

  screenRedirect() async {
    final user = _auth.currentUser;
    //if user is not null
    if (user != null) {
      //if email is verified
      if (user.emailVerified) {
        await FLocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => verifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      //if user is null
      //local storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  //---------------------------------------email and signin------------------
  //Log in
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //Register// create new account
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  // Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //-REauthenticate user
  Future<void> reAuthenticateWithEmailandPassword(
      String email, String password) async {
    try {
      //create credentials
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      // reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //Forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //-------------------Social Sign in

  // google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // trigger authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      //obtain authentication details of accounts
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //once signed in return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print('Something went Wrong: $e');
        return null;
      }
    }
    return null;
  }

  // Facebook

  // -------------------Logout User
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //--------------------- Delete User

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserDetail(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw FFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const FFormatExceptions();
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }
}

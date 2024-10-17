import 'dart:io';

import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/features/personalization/models/user_model.dart';
import 'package:af_store/utils/exception/firebase_exceptions.dart';
import 'package:af_store/utils/exception/format_exceptions.dart';
import 'package:af_store/utils/exception/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // function to save user data in firestore

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  //function to fetch user data
  Future<UserModel> fetchUserDetail() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //function to update user data
  Future<void> updateUserDetail(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
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

  //update any fields in specific user document
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser.uid)
          .update(json);
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

  //funtion to remove user data
  Future<void> removeUserDetail(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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

  // upload any image from firestore storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

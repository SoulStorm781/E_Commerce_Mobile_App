import 'package:af_store/data/services/firebase_storage_services.dart';
import 'package:af_store/features/shop/models/category_model.dart';
import 'package:af_store/utils/exception/firebase_exceptions.dart';
import 'package:af_store/utils/exception/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables

  final _db = FirebaseFirestore.instance;
  //get all categories

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  //get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }

  // upload categories to firebase firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //uplaod all categories along with their images
      final storage = Get.put(FFirebaseStorageServices());

      //loop through the categories and upload them to firestore
      for (var category in categories) {
        // get image data link from local asset
        final file = await storage.getImageDataFromAssets(category.image);

        //upload image gets it url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        //assign url to category image
        category.image = url;

        //store category in firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later';
    }
  }
}

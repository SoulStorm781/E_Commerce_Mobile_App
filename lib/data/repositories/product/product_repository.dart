import 'dart:io';
import 'package:af_store/data/services/firebase_storage_services.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/exception/firebase_exceptions.dart';
import 'package:af_store/utils/exception/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final Logger logger = Logger();

  //get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(7)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      // return products;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, dont know what';
    }
  }

  //get All limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again later';
    }
  }

  //get products based on brand
  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again later';
    }
  }

  //get favorites products

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again later';
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final product = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return product;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again later';
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((e) => e['productId'] as String)
          .toList();

      final productQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products =
          productQuery.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      return products;
    } on FirebaseException catch (e) {
      throw FFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw FPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again later';
    }
  }

  //upload dummy data to cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      //upload all products along with their images
      final storage = Get.put(FFirebaseStorageServices());

      // loop through each product
      for (var product in products) {
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);
        //upload image and its url
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());

        //asign url to product.thumbnail attribute
        product.thumbnail = url;

        //product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            //get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            //upload image and its url
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            //assign url to product.thumbnail attribute
            imagesUrl.add(url);
          }
          // product.images! = clear();
          product.images!.addAll(imagesUrl);
        }

        //upload variation images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            //assign url to product.thumbnail attribute
            variation.image = url;
          }
        }
        //store product in firestore
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}

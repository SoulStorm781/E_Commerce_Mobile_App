import 'package:af_store/features/shop/models/brand_model.dart';
import 'package:af_store/features/shop/models/product_attribute_model.dart';
import 'package:af_store/features/shop/models/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  String productType;
  List<String>? images;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.productType,
    required this.price,
    required this.title,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.salePrice = 0.0,
    this.description,
    this.categoryId,
    this.sku,
    this.images,
    this.productAttributes,
    this.productVariations,
  });

  //empty helper function
  static ProductModel empty() => ProductModel(
        id: '',
        stock: 0,
        productType: '',
        price: 0,
        title: '',
        thumbnail: '',
      );

  //json format
  toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'SKU': sku,
      'Price': price,
      'Title': title,
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      'Brand': brand?.toJson(),
      'Description': description,
      'CategoryId': categoryId,
      'ProductType': productType,
      'Images': images ?? [],
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariation': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  //map json data to documnet snapshot from firebase to usermodel
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    // if (document.data() == null) {
    //   return ProductModel.empty();
    // }
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(data['Brand']),
      description: data['Description'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      productType: data['ProductType'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariations: data['ProductVariation'] != null
          ? (data['ProductVariation'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
    );
  }

  //map json data to documnet snapshot from firebase to usermodel
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(data['Brand']),
      description: data['Description'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      productType: data['ProductType'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariations: data['ProductVariation'] != null
          ? (data['ProductVariation'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
    );
  }
}

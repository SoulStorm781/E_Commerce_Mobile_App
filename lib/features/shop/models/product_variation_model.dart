class ProductVariationModel {
  final String id;
  String sku;
  double price;
  double salePrice;
  int stock;
  String image;
  String? description;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.image = '',
    this.sku = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.description = '',
    required this.attributeValues,
  });

  //empty helper function
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  //json format
  toJson() {
    return {
      'Id': id,
      'Image': image,
      'SKU': sku,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'Description': description,
      'AttributesValues': attributeValues,
    };
  }

  //map json data to documnet snapshot from firebase to usermodel
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return ProductVariationModel.empty();
    }
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      sku: data['SKU'] ?? '',
      description: data['Description'] ?? '',
      stock: int.tryParse(data['Stock'].toString()) ?? 0,
      attributeValues: Map<String, String>.from(data['AttributesValues']),
    );
  }
}

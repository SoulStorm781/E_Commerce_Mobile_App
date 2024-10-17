import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/controllers/product/images_controller.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();
  //variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  //selsct attributs on variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // show selected variation image as main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    //assign selected varaition

    this.selectedVariation.value = selectedVariation;

    //update selected variation stock status
    getVariationStockStatus();
  }

//chekc if selected attributes matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    //if selested attributes contain 3 attributes and current variation contain 2 then returns
    if (variationAttributes.length != selectedAttributes.length) return false;

    //if any attribute is different then returns
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

//check attribute availability
  Set<String?> getAttributesAvailability(
      List<ProductVariationModel> variations, String attributeName) {
    final availabaleVariationAttributes = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availabaleVariationAttributes;
  }

  //get varaition price
  String getVariationPrice() {
    return selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice.toString()
        : selectedVariation.value.price.toString();
  }

//check product avriation stock status
  void getVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  //reset selected variation on switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}

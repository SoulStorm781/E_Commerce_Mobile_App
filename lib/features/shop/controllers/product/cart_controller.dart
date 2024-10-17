import 'package:af_store/features/shop/controllers/product/variation_controller.dart';
import 'package:af_store/features/shop/models/cart_item_model.dart';
import 'package:af_store/features/shop/models/product_model.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/local_storage/storage_utility.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  //Add item to cart
  void addToCart(ProductModel product) {
    //quantity check
    if (productQuantityInCart.value < 1) {
      FLoaders.customToast(message: 'Selected Quantity');
      return;
    }
    // variation check
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      FLoaders.customToast(message: 'Select a variation');
      return;
    }

    //out of stock check
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        FLoaders.warningSnackBar(
            message: 'Selected variation is out of stock', title: 'Oh Snap!');
        return;
      }
    } else {
      if (product.stock < 1) {
        FLoaders.warningSnackBar(
            message: 'Selected Product is out of stock', title: 'Oh Snap!');
        return;
      }
    }
    //convert product model to cart item  model with given quantity
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    //check if the product is already in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    //update cart
    updateCart();
    FLoaders.customToast(message: 'Your product has been added to the cart');
  }

//

  //add one to cart
  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  //remove one from cart
  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this Product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        FLoaders.customToast(message: 'Product removed from cart');
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  //this function convert product model to cart item  model
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      //reset variation in case of single product
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

//update cart values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;

    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    FLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        FLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  // void updateAlreadyAddedProductCount(ProductModel product) {
  //   if (product.productType == ProductType.single.toString()) {
  //     productQuantityInCart.value = getProductQuantityInCart(product.id);
  //   } else {
  //     final variationId = variationController.selectedVariation.value.id;
  //     if (variationId.isNotEmpty) {
  //       productQuantityInCart.value =
  //           getVariationQuantityInCart(product.id, variationId);
  //     } else {
  //       productQuantityInCart.value = 0;
  //     }
  //   }
  // }

  //

  void updateAlreadyAddedProductCount(ProductModel product) {
    int cartQuantity = 0;
    if (product.productType == ProductType.single.toString()) {
      cartQuantity = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        cartQuantity = getVariationQuantityInCart(product.id, variationId);
      }
    }
    productQuantityInCart.value =
        cartQuantity > 0 ? cartQuantity : 1; // Ensures a default of 1
  }
}

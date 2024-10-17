import 'package:af_store/data/repositories/authentication_rep/authentication_rep.dart';
import 'package:af_store/data/repositories/order/order_repository.dart';
import 'package:af_store/features/authentication/screens/signup/success_screen.dart';
import 'package:af_store/features/personalization/controllers/address_controller.dart';
import 'package:af_store/features/shop/controllers/product/cart_controller.dart';
import 'package:af_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:af_store/features/shop/models/order_model.dart';
import 'package:af_store/navigation_menu.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/popups/full_screen_loader.dart';
import 'package:af_store/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //variables

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      FLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //add methods for  order processing
  void processOrder(double totalAmount) async {
    try {
      //start loader
      FFullScreenLoader.openLoadingDialog(
          'Processing your Order', FImages.process);

      //get user authentication id

      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      //add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.Pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      //save order to firestore
      await orderRepository.saveOrder(order, userId);

      //update cart status
      cartController.clearCart();

      //show success screen
      Get.off(
        () => SuccessScreen(
          image: FImages.successfullpayment,
          title: 'Payment Success!',
          subtitle: 'Your Item will bw Shipped Soon!',
          onPressed: () => Get.offAll(
            () => const NavigationMenu(),
          ),
        ),
      );
    } catch (e) {
      FLoaders.errorSnackBar(
          title: 'Order Processing Failed', message: e.toString());
    }
  }
}

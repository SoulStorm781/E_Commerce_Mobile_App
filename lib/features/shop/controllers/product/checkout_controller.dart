import 'package:af_store/common/widgets/text/section_heading.dart';
import 'package:af_store/features/shop/models/payment_method_model.dart';
import 'package:af_store/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:af_store/utils/constants/image_strings.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  //variables
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: FImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(FSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FSectionHeading(
                        title: 'Select Payment Method',
                        showActionButtion: false),
                    const SizedBox(height: FSizes.spaceBtwSections),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Paypal', image: FImages.paypal)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'GooglePay', image: FImages.googlepay)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Visa', image: FImages.visa)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'MasterCard', image: FImages.mastercard)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'CreditCard', image: FImages.creditcard)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    FPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'ApplePay', image: FImages.applepay)),
                    const SizedBox(
                      height: FSizes.spaceBtwItems / 2,
                    ),
                    const SizedBox(
                      height: FSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ));
  }
}

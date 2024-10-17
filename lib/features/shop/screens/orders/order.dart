import 'package:af_store/common/widgets/appbar/appbar.dart';
import 'package:af_store/features/shop/screens/orders/widgets/order_list.dart';
import 'package:af_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(FSizes.defaultSpace),
        //order list
        child: FOrderListItems(),
      ),
    );
  }
}

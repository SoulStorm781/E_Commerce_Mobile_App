import 'package:af_store/features/personalization/models/address_model.dart';
import 'package:af_store/features/shop/models/cart_item_model.dart';
import 'package:af_store/utils/constants/enums.dart';
import 'package:af_store/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'PayPal',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => FHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? FHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.Delivered
      ? 'Delivered'
      : status == OrderStatus.Shipped
          ? 'Shipped'
          : 'Processing';
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   final data = snapshot.data() as Map<String, dynamic>;

  //   return OrderModel(
  //     id: data['id'] as String,
  //     userId: data['userId'] as String,
  //     status: OrderStatus.values
  //         .firstWhere((element) => element.toString() == data['status']),
  //     totalAmount: data['totalAmount'] as double,
  //     orderDate: data['orderDate'] != null
  //         ? (data['orderDate'] as Timestamp).toDate()
  //         : DateTime.now(),
  //     paymentMethod: data['paymentMethod'] as String,
  //     address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
  //     deliveryDate: data['deliveryDate'] != null
  //         ? (data['deliveryDate'] as Timestamp).toDate()
  //         : null,
  //     items: (data['items'] as List<dynamic>)
  //         .map((itemData) =>
  //             CartItemModel.fromJson(itemData as Map<String, dynamic>))
  //         .toList(),
  //   );
  // }

  //

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere(
        (element) => element.toString() == data['status'],
        orElse: () => OrderStatus.Pending, // Default in case of mismatch
      ),
      totalAmount:
          data['totalAmount'] != null ? data['totalAmount'] as double : 0.0,
      orderDate: data['orderDate'] != null
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(), // Provide a default value if null
      paymentMethod: data['paymentMethod'] ?? 'Unknown', // Provide default
      address: data['address'] != null
          ? AddressModel.fromMap(data['address'] as Map<String, dynamic>)
          : null, // Handle missing address
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null, // Allow null delivery date
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}

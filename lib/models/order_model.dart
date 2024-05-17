import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  String? sellerId;
  String? customerId;

  List? productNames;
  List? productImages;
  List? productPrices;
  List? productIds;
  List? productQuantities;

  double? orderPrice;
  String? orderStatus;
  DateTime? deliveryDate;
  DateTime? orderDate;
  String? paymentStatus;

  bool? isRated;

  OrderModel({
    this.orderId,
    this.sellerId,
    this.customerId,
    this.productNames,
    this.productImages,
    this.productPrices,
    this.productIds,
    this.productQuantities,
    this.orderPrice,
    this.orderStatus,
    this.deliveryDate,
    this.orderDate,
    this.paymentStatus,
    this.isRated,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': this.orderId,
      'sellerId': this.sellerId,
      'customerId': this.customerId,
      'productNames': this.productNames,
      'productImages': this.productImages,
      'productPrices': this.productPrices,
      'productIds': this.productIds,
      'productQuantities': this.productQuantities,
      'orderPrice': this.orderPrice,
      'orderStatus': this.orderStatus,
      'deliveryDate': this.deliveryDate,
      'orderDate': this.orderDate,
      'paymentStatus': this.paymentStatus,
      'isRated': isRated,
    };
  }

  factory OrderModel.fromMap(DocumentSnapshot map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      sellerId: map['sellerId'] as String,
      customerId: map['customerId'] as String,
      productNames: map['productNames'] as List,
      productImages: map['productImages'] as List,
      productPrices: map['productPrices'] as List,
      productIds: map['productIds'] as List,
      productQuantities: map['productQuantities'] as List,
      orderPrice: map['orderPrice'] as double,
      orderStatus: map['orderStatus'] as String,
      deliveryDate: (map['deliveryDate'].toDate()),
      orderDate: (map['orderDate'].toDate()),
      paymentStatus: map['paymentStatus'] as String,
      isRated: map['isRated'] as bool,
    );
  }
}

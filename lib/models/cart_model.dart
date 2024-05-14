import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? pdtId;
  String? userId;
  int? quantity;
  double? price;
  String? supplierId;

  CartModel({
    this.pdtId,
    this.userId,
    this.quantity,
    this.price,
    this.supplierId,
  });

  Map<String, dynamic> toMap() {
    return {
      'pdtId': this.pdtId,
      'userId': this.userId,
      'quantity': this.quantity,
      'price': this.price,
      'supplierId': this.supplierId,
    };
  }

  factory CartModel.fromMap(DocumentSnapshot map) {
    if (map.exists) {
      return CartModel(
        pdtId: map['pdtId'] as String,
        userId: map['userId'] as String,
        quantity: map['quantity'] as int,
        price: map['price'] as double,
        supplierId: map['supplierId'] as String,
      );
    } else {
      return CartModel();
    }
  }
}

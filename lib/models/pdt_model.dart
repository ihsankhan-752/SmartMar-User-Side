import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? category;
  String? pdtName;
  double? pdtPrice;
  double? discount;
  String? pdtDescription;
  String? pdtId;
  List? pdtImages;
  int? quantity;
  String? sellerId;

  ProductModel({
    this.category,
    this.pdtName,
    this.pdtId,
    this.sellerId,
    this.quantity,
    this.discount,
    this.pdtDescription,
    this.pdtImages,
    this.pdtPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': this.category,
      'pdtName': this.pdtName,
      'pdtPrice': this.pdtPrice,
      'discount': this.discount,
      'pdtDescription': this.pdtDescription,
      'pdtId': this.pdtId,
      'pdtImages': this.pdtImages,
      'quantity': this.quantity,
      'sellerId': this.sellerId,
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot map) {
    return ProductModel(
      category: map['category'] as String,
      pdtName: map['pdtName'] as String,
      pdtPrice: map['pdtPrice'] as double,
      discount: map['discount'] as double,
      pdtDescription: map['pdtDescription'] as String,
      pdtId: map['pdtId'] as String,
      pdtImages: map['pdtImages'],
      quantity: map['quantity'] as int,
      sellerId: map['sellerId'] as String,
    );
  }
}

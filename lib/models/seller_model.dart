import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel {
  String? uid;
  String? sellerName;
  String? email;
  String? address;
  int? phone;
  String? image;
  DateTime? memberSince;

  SellerModel({
    this.uid,
    this.email,
    this.sellerName,
    this.address,
    this.phone,
    this.image,
    this.memberSince,
  });

  factory SellerModel.fromDocument(DocumentSnapshot snap) {
    return SellerModel(
        uid: snap['uid'],
        email: snap['email'],
        sellerName: snap['sellerName'],
        address: snap['address'],
        phone: snap['phone'],
        image: snap['image'],
        memberSince: (snap['memberSince'].toDate()),);
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "sellerName": sellerName,
      "email": email,
      "address": address,
      "phone": phone,
      "image": image,
      'memberSince': memberSince,
    };
  }
}

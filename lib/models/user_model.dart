import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? address;
  int? phone;
  String? image;
  List? cart;
  List? wishlist;
  List? storeFollowers;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.address,
    this.phone,
    this.image,
    this.cart,
    this.wishlist,
    this.storeFollowers,
  });

  factory UserModel.fromDocument(DocumentSnapshot snap) {
    return UserModel(
        uid: snap['uid'],
        email: snap['email'],
        username: snap['username'],
        address: snap['address'],
        phone: snap['phone'],
        image: snap['image'],
        cart: snap['cart'],
        wishlist: snap['wishlist'],
        storeFollowers: snap['storeFollowers']);
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": username,
      "email": email,
      "address": address,
      "phone": phone,
      "image": "",
      "cart": [],
      "wishlist": [],
      "storeFollowers": [],
      "isSupplier": false,
    };
  }
}

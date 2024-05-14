import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? country;
  String? state;
  String? city;
  int? phone;
  String? image;
  List? cart;
  List? wishlist;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.country,
    this.state,
    this.city,
    this.phone,
    this.image,
    this.cart,
    this.wishlist,
  });

  factory UserModel.fromDocument(DocumentSnapshot snap) {
    return UserModel(
      uid: snap['uid'],
      email: snap['email'],
      username: snap['userName'],
      country: snap['country'],
      state: snap['state'],
      city: snap['city'],
      phone: snap['phone'],
      image: snap['image'],
      cart: snap['cart'],
      wishlist: snap['wishlist'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": username,
      "email": email,
      "country": country,
      "state": state,
      "city": city,
      "phone": phone,
      "image": "",
      "cart": [],
      "wishlist": [],
    };
  }
}

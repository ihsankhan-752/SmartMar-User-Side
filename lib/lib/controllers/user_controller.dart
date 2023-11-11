import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  List _cart = [];
  List _wishlist = [];
  String _username = '';
  String _userImage = '';
  String _email = '';

  String get username => _username;
  String get userImage => _userImage;
  List get cart => _cart;
  List get wishlist => _wishlist;
  String get email => _email;

  getUser() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      _username = snap['userName'];
      _userImage = snap['image'];
      _cart = snap['cart'];
      _email = snap['email'];
      _wishlist = snap['wishlist'];
      notifyListeners();
    }
  }
}

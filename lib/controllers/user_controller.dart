import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_mart_user_side/models/user_model.dart';

class UserController extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  getUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((snap) {
        if (snap.docs.isNotEmpty) {
          _userModel = UserModel.fromDocument(snap.docs.first);
          notifyListeners();
        } else {
          print('No documents found for the current user.');
        }
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}

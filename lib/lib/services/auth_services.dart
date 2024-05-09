import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/custom_msg.dart';
import 'package:smart_mart_user_side/lib/services/storage_services.dart';

import '../controllers/loading_controller.dart';
import '../models/user_model.dart';
import '../utils/functions/functions.dart';
import '../views/auth/login_screen.dart';
import '../views/bottom_nav_bar/custom_bottom_navigation_bar.dart';

class AuthServices {
  Future<String> signUp({BuildContext? context, String? email, String? password, String? username, File? selectedImage}) async {
    String response = "";
    try {
      var _auth = FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      String image = await StorageServices().uploadImageToStorage(context!, selectedImage);
      UserModel userModel = UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: email,
        username: username,
        image: image,
        isSuppler: false,
      );
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toMap());
      response = 'success';
      navigateToPageWithPush(context, CustomBottomNavigation());
    } on FirebaseException catch (e) {
      response = e.message.toString();
    }
    return response;
  }

  signIn(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomMsg(context: context, msg: 'All Fields are Required');
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        navigateToPageWithPush(context, CustomBottomNavigation());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context: context, msg: e.message!);
      }
    }
  }

  static signOut(BuildContext context) async {
    var _auth = FirebaseAuth.instance;
    _auth.signOut().then((value) {
      navigateToPageWithPush(context, LoginScreen());
    });
  }
}

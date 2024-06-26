import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/loading_controller.dart';
import '../constants/navigations.dart';
import '../models/user_model.dart';
import '../screens/auth/login_screen.dart';
import '../screens/bottom_nav_bar/custom_bottom_navigation_bar.dart';
import '../widgets/custom_msg.dart';

class AuthServices {
  Future<void> signUp({
    BuildContext? context,
    String? email,
    String? password,
    String? username,
    int? contact,
  }) async {
    if (username!.isEmpty) {
      showCustomMsg(context: context, msg: 'username required');
    } else if (email!.isEmpty) {
      showCustomMsg(context: context, msg: 'Email required');
    } else if (contact == null) {
      showCustomMsg(context: context, msg: 'Contact required');
    } else if (password!.isEmpty) {
      showCustomMsg(context: context, msg: 'Password required');
    } else {
      try {
        Provider.of<LoadingController>(context!, listen: false).setLoading(true);

        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        UserModel userModel = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          username: username,
          address: "",
          phone: contact,
        );
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toMap());
        Provider.of<LoadingController>(context, listen: false).setLoading(false);

        navigateToPageWithPush(context, CustomBottomNavigation());
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context!, listen: false).setLoading(false);

        showCustomMsg(context: context, msg: e.message!);
      }
    }
  }

  Future<void> signIn(BuildContext context, String email, String password) async {
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

  Future<void> resetPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      showCustomMsg(context: context, msg: "Email required");
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context: context, msg: "Please Check your Email and reset your password");

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context: context, msg: e.message!);
      }
    }
  }

  static Future<bool> checkOldPasswordCreative(email, password) async {
    AuthCredential authCredential = EmailAuthProvider.credential(email: email, password: password);
    try {
      var credentialResult = await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(authCredential);
      return credentialResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> changeUserPasswordCreative({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (oldPassword.isEmpty) {
      showCustomMsg(context: context, msg: "Old password required");
    } else if (newPassword.isEmpty) {
      showCustomMsg(context: context, msg: "New password required");
    } else if (newPassword != confirmPassword) {
      showCustomMsg(context: context, msg: "Password does not match");
    } else {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      bool checkPassword = true;
      checkPassword = await checkOldPasswordCreative(
        FirebaseAuth.instance.currentUser!.email,
        oldPassword,
      );
      if (checkPassword) {
        try {
          await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
          Provider.of<LoadingController>(context, listen: false).setLoading(false);

          showCustomMsg(context: context, msg: "Password Updated Successfully");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } catch (e) {
          Provider.of<LoadingController>(context, listen: false).setLoading(false);
          showCustomMsg(context: context, msg: e.toString());
        }
      } else {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context: context, msg: "Invalid Password");
      }
    }
  }
}

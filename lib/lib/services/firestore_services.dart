import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/custom_msg.dart';

class FireStoreServices {
  Future addItemToWishlist(BuildContext context, String pdtId) async {
    try {
      DocumentSnapshot productSnap = await FirebaseFirestore.instance.collection("products").doc(pdtId).get();
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snap['wishlist'].contains(pdtId)) {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "wishlist": FieldValue.arrayRemove([pdtId]),
        });
      } else {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "wishlist": FieldValue.arrayUnion([pdtId]),
        });
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context: context, msg: e.message);
    }
  }

  Future addItemToCart(BuildContext context, String pdtId) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snap['cart'].contains(pdtId)) {
        showCustomMsg(context: context, msg: "Item already Exits in Cart");
      } else {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "cart": FieldValue.arrayUnion([pdtId]),
        });
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context: context, msg: e.message);
    }
  }

  Future myCart({BuildContext? context, dynamic productInfo}) async {
    try {
      DocumentSnapshot pdtSnap =
          await FirebaseFirestore.instance.collection("products").doc(productInfo['pdtId']).get();
      await FirebaseFirestore.instance.collection("mycart").doc(productInfo['pdtId']).set({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "pdtId": productInfo['pdtId'],
        "quantity": 1,
        "price": productInfo['price'],
        "supplierId": pdtSnap['supplierId'],
      });
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
  }

  Future incrementPdtQuantity(BuildContext context, dynamic pdtIds, int index, dynamic quantity) async {
    try {
      FirebaseFirestore.instance.collection("mycart").doc(pdtIds[index]).update({
        "quantity": quantity++,
      });
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
  }
}

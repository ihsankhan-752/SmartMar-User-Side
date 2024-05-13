import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_msg.dart';

class WishlistServices {
  Future addItemToWishlist(BuildContext context, String pdtId) async {
    try {
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

import 'firestore_services.dart';

class CartServices {
  static addItemToCartFromWishList({
    required BuildContext context,
    required UserController userController,
    required ProductModel productModel,
  }) async {
    try {
      if (userController.userModel!.cart!.contains(productModel.pdtId)) {
        showCustomMsg(context: context, msg: "Item Already Exist in Cart!");
      } else {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "cart": FieldValue.arrayUnion([productModel.pdtId]),
        });
        await FireStoreServices().myCart(context: context, productModel: productModel);
        showCustomMsg(context: context, msg: "Item is Added to Cart Successfully!");
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context: context, msg: e.message!);
    }
  }
}

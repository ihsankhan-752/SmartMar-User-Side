import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/models/cart_model.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

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
        await CartServices().myCart(context: context, productModel: productModel);
        showCustomMsg(context: context, msg: "Item is Added to Cart Successfully!");
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context: context, msg: e.message!);
    }
  }

  static removeItemFromCart(String pdtId) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(pdtId).delete();
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'cart': FieldValue.arrayRemove([pdtId]),
      });
    } on FirebaseException catch (e) {
      print(e);
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
        showCustomMsg(context: context, msg: "Item added to Cart");
      }
    } on FirebaseException catch (e) {
      showCustomMsg(context: context, msg: e.message);
    }
  }

  Future myCart({BuildContext? context, ProductModel? productModel}) async {
    try {
      DocumentSnapshot pdtSnap = await FirebaseFirestore.instance.collection("products").doc(productModel!.pdtId).get();

      CartModel cartModel = CartModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        pdtId: productModel.pdtId,
        quantity: 1,
        price: productModel.pdtPrice,
        supplierId: pdtSnap['sellerId'],
      );
      await FirebaseFirestore.instance.collection("cart").doc(productModel.pdtId).set(cartModel.toMap());
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
  }

  Future incrementPdtQuantity(BuildContext context, String pdtId, int quantity) async {
    try {
      FirebaseFirestore.instance.collection("cart").doc(pdtId).update({
        "quantity": quantity++,
      });
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
  }

  Future decrementPdtQuantity(BuildContext context, String pdtId, int quantity) async {
    try {
      FirebaseFirestore.instance.collection("cart").doc(pdtId).update({
        "quantity": quantity--,
      });
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
  }
}

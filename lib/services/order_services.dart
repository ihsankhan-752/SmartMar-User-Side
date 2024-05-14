import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/models/order_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/custom_bottom_navigation_bar.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';
import 'package:uuid/uuid.dart';

class OrderServices {
  Future<void> makeOrder({
    required BuildContext context,
    required List productIds,
    required double totalPrice,
    required List quantities,
    required String sellerId,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      var orderId = Uuid().v1();

      List pdtNames = [];
      List pdtImages = [];
      List pdtPrices = [];
      List pdtIds = [];
      for (var id in productIds) {
        DocumentSnapshot pdtSnap = await FirebaseFirestore.instance.collection("products").doc(id).get();
        pdtNames.add(pdtSnap['pdtName']);
        pdtImages.add(pdtSnap['pdtImages'][0]);
        pdtPrices.add(pdtSnap['pdtPrice']);
        pdtIds.add(id);
      }
      print(pdtNames);

      OrderModel orderModel = OrderModel(
        orderId: orderId,
        sellerId: sellerId,
        customerId: FirebaseAuth.instance.currentUser!.uid,
        productNames: pdtNames,
        productImages: pdtImages,
        productPrices: pdtPrices,
        productIds: productIds,
        productQuantities: quantities,
        orderPrice: totalPrice,
        orderStatus: "preparing",
        deliveryDate: DateTime.now(),
        orderDate: DateTime.now(),
        paymentStatus: "COD",
      );

      await FirebaseFirestore.instance.collection('orders').doc(orderId).set(orderModel.toMap());

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'cart': [],
      });

      QuerySnapshot cartSnap = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (var i in cartSnap.docs) {
        i.reference.delete();
      }
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.to(() => CustomBottomNavigation());
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      showCustomMsg(context: context, msg: e.message!);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/models/rating_model.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

class RatingServices {
  Future<void> addRating({
    required BuildContext context,
    required String orderId,
    required String productId,
    required String comment,
    required double rating,
  }) async {
    if (comment.isEmpty) {
      showCustomMsg(context: context, msg: "Write Something");
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        DocumentSnapshot snap =
            await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

        RatingModel ratingModel = RatingModel(
          comment: comment,
          ratingDate: DateTime.now(),
          rating: rating,
          userId: FirebaseAuth.instance.currentUser!.uid,
          userName: snap['userName'],
          userImage: snap['image'],
        );
        await FirebaseFirestore.instance.collection('products').doc(productId).collection('reviews').add(ratingModel.toMap());
        await FirebaseFirestore.instance.collection('orders').doc(orderId).update({'isRated': true});
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        Get.back();
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(context, listen: false).setLoading(false);
        showCustomMsg(context: context, msg: e.message!);
      }
    }
  }
}

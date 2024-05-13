import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

class UserProfileServices {
  static updateUserAddress({required BuildContext context, String? address}) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'address': address,
      });
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.back();
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      showCustomMsg(context: context, msg: e.message!);
    }
  }
}

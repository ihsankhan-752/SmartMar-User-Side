import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/loading_controller.dart';
import 'package:smart_mart_user_side/services/storage_services.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

import '../constants/image_compressor.dart';

class UserProfileServices {
  static updateProfileInformation({
    required BuildContext context,
    String? newName,
    File? image,
    int? phone,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      String? imageUrl;
      if (image != null) {
        File _compressImage = await compressImage(image);
        imageUrl = await StorageServices().uploadImageToStorage(context, _compressImage);
      }

      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'userName': newName,
        'phone': phone ?? snap['phone'],
        'image': imageUrl ?? snap['image'],
      });
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.back();
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      showCustomMsg(context: context, msg: e.message!);
    }
  }

  static updateUserAddress({
    required BuildContext context,
    String? country,
    String? state,
    String? city,
  }) async {
    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'country': country,
        'state': state,
        'city': city,
      });
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.back();
    } on FirebaseException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      showCustomMsg(context: context, msg: e.message!);
    }
  }
}

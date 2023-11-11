import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../custom_widgets/custom_msg.dart';

class StorageServices {
  Future<String> uploadImageToStorage(BuildContext context, File? image) async {
    String url = '';
    try {
      FirebaseStorage fs = FirebaseStorage.instance;
      Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(File(image!.path));
      url = await ref.getDownloadURL();
    } catch (e) {
      showCustomMsg(context: context, msg: e.toString());
    }
    return url;
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  uploadPhoto(ImageSource source) async {
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    if (_pickedFile != null) {
      _selectedImage = File(_pickedFile.path);
      notifyListeners();
    }
  }

  removeUploadPhoto() {
    _selectedImage = null;
    notifyListeners();
  }
}

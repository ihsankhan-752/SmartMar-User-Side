import 'package:flutter/cupertino.dart';

class AppTextController extends ChangeNotifier {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController contactController = TextEditingController();

  clear() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    addressController.clear();
    contactController.clear();

    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VisibilityController extends ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  hideAndUnHideVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isOldPasswordVisible = true;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isOldPasswordVisible => _isOldPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void toggleOldPasswordVisibility() {
    _isOldPasswordVisible = !_isOldPasswordVisible;
    notifyListeners();
  }

  set visibility(newValue) {
    _isVisible = newValue;
    notifyListeners();
  }
}

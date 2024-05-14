import 'package:flutter/material.dart';

showCustomMsg({BuildContext? context, String? msg}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      content: Text(msg!),
    ),
  );
}

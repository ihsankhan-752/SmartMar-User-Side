import 'package:flutter/material.dart';

import '../utils/styles/colors.dart';

class CustomTextFields extends StatelessWidget {
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? obSecure;
  final Widget? suffixIcon;
  const CustomTextFields({
    Key? key,
    this.labelText,
    this.controller,
    this.obSecure = false,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 100,
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(labelText!),
          suffixIcon: suffixIcon,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.pinkish),
          ),
        ),
      ),
    );
  }
}

class AuthTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isSuffixReq;
  final bool isTextSecure;
  final Widget? suffixIcon;
  const AuthTextInput(
      {Key? key, this.controller, this.hintText, this.isSuffixReq = false, this.suffixIcon, this.isTextSecure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        style: TextStyle(
          color: AppColors.primaryWhite,
        ),
        obscureText: isTextSecure,
        controller: controller,
        cursorColor: AppColors.grey,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 18, left: 10),
          hintText: hintText!,
          hintStyle: TextStyle(
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          suffixIcon: isSuffixReq ? suffixIcon : SizedBox(),
        ),
      ),
    );
  }
}

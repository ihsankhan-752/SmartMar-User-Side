import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

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
  final String? hintText, labelText;
  final bool isTextSecure;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  const AuthTextInput(
      {Key? key, this.controller, this.hintText, this.inputType, this.suffixIcon, this.isTextSecure = false, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      obscureText: isTextSecure,
      decoration: InputDecoration(
        isDense: true,
        counter: SizedBox.shrink(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xff2b2b2b),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(fontSize: 14, color: Color(0xff2b2b2b).withOpacity(0.4)),
        suffixIcon: suffixIcon ?? SizedBox(),
      ),
    );
  }
}

class SearchTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String? v)? onChange;
  final Function()? onCrossIconClick;
  const SearchTextInput({Key? key, this.controller, this.hintText, this.onChange, this.onCrossIconClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        counter: SizedBox.shrink(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 22),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        hintText: hintText,
        suffixIcon:
            controller!.text.isEmpty ? SizedBox() : GestureDetector(onTap: onCrossIconClick ?? () {}, child: Icon(Icons.close)),
        hintStyle: GoogleFonts.nunito(fontSize: 14.5, color: Color(0xff2b2b2b).withOpacity(0.8)),
      ),
    );
  }
}

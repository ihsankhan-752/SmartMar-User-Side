import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  const AuthenticationButton({Key? key, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        height: 35,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow,
        ),
        child: Center(
          child: Text(title!),
        ),
      ),
    );
  }
}

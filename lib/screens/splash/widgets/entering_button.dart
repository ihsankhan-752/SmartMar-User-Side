import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../auth/login_screen.dart';
import '../../auth/signup_screen.dart';
import 'authentication_button.dart';

class EnteringButton extends StatelessWidget {
  const EnteringButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AuthenticationButton(
              title: "Login",
              onPressed: () {
                navigateToPageWithPush(context, LoginScreen());
              }),
          AuthenticationButton(
              title: "Sign Up",
              onPressed: () {
                navigateToPageWithPush(context, SignUpScreen());
              }),
        ],
      ),
    );
  }
}

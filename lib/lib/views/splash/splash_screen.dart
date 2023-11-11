import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/logo_widget.dart';
import 'package:smart_mart_user_side/lib/utils/styles/colors.dart';

import '../../utils/functions/functions.dart';
import '../bottom_nav_bar/custom_bottom_navigation_bar.dart';
import 'onboarding_one.dart';

class splash_screen extends StatefulWidget {
  static const routeName = '/main_splash';
  const splash_screen({Key? key}) : super(key: key);

  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    var auth = FirebaseAuth.instance.currentUser;

    Timer(Duration(seconds: 3), () {
      if (auth == null) {
        navigateWithPushNamed(context, OnBoardingOne.routeName, "");
      } else {
        navigateToPageWithPush(context, CustomBottomNavigation());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoWidget(),
        ],
      ),
    );
  }
}

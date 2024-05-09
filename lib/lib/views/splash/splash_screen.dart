import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/lib/custom_widgets/logo_widget.dart';

import '../../utils/functions/functions.dart';
import '../bottom_nav_bar/custom_bottom_navigation_bar.dart';
import 'onboarding_one.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var auth = FirebaseAuth.instance.currentUser;

    Timer(Duration(seconds: 3), () {
      if (auth == null) {
        navigateToPageWithPush(context, OnBoardingOne());
      } else {
        navigateToPageWithPush(context, CustomBottomNavigation());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoWidget(),
        ],
      ),
    );
  }
}

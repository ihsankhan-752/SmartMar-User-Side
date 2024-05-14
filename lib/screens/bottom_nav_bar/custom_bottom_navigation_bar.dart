import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/cart/cart_screen.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/profile_screen.dart';

import '../../constants/colors.dart';
import '../../controllers/user_controller.dart';
import '../../services/notification_services.dart';
import 'home/home_screen.dart';
import 'notifications/notification_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  List<dynamic> cartList = [];
  List<dynamic> wishlist = [];

  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).getUser();
    NotificationServices().initNotification(context);
    NotificationServices().getPermission();
    NotificationServices().getDeviceToken();
    getUserData();
    super.initState();
  }

  getUserData() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      cartList = snap['cart'];
      wishlist = snap['wishlist'];
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List Pages = [
      HomeScreen(),
      CartScreen(),
      NotificationScreen(),
      ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Pages[_currentIndex],
        bottomNavigationBar: Container(
          height: 60,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomWidgetSelection(
                  title: "Home",
                  icon: FontAwesomeIcons.house,
                  activeColor: _currentIndex == 0 ? AppColors.primaryColor : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                CustomWidgetSelection(
                  title: "Cart",
                  activeColor: _currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
                  icon: Icons.shopping_cart_outlined,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                CustomWidgetSelection(
                  title: "Notifications",
                  icon: Icons.notifications_none,
                  activeColor: _currentIndex == 2 ? AppColors.primaryColor : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                CustomWidgetSelection(
                  title: "Account",
                  activeColor: _currentIndex == 3 ? AppColors.primaryColor : Colors.grey,
                  icon: Icons.person,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final Color? activeColor;
  final String? title;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.activeColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: activeColor, size: 22),
          Text(
            title!,
            style: TextStyle(
              color: activeColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}

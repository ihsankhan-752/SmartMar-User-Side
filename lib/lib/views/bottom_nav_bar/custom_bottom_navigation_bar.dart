import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/lib/controllers/user_controller.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/notifications/notification_screen.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/wishlist/my_wishlist.dart';
import 'package:smart_mart_user_side/lib/views/profile/profile_screen.dart';

import '../../services/notification_services.dart';
import '../../utils/styles/colors.dart';
import 'home/home_screen.dart';

class CustomBottomNavigation extends StatefulWidget {
  static String routeName = "/customer_home";
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
      MyWishListScreen(wishlist: wishlist, cartList: cartList),
      NotificationScreen(),
      ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlack,
        body: Pages[_currentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.mainColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomWidgetSelection(
                icon: FontAwesomeIcons.house,
                iconColor: _currentIndex == 0 ? AppColors.primaryWhite : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              CustomWidgetSelection(
                iconColor: _currentIndex == 1 ? AppColors.primaryWhite : Colors.grey,
                icon: Icons.favorite_border,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              CustomWidgetSelection(
                icon: Icons.notifications_active_outlined,
                iconColor: _currentIndex == 2 ? AppColors.primaryWhite : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              CustomWidgetSelection(
                iconColor: _currentIndex == 3 ? AppColors.primaryWhite : Colors.grey,
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
    );
  }
}

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final Color? iconColor;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/widgets/custom_widget_selection.dart';

import '../../constants/colors.dart';
import '../../constants/lists.dart';
import '../../controllers/user_controller.dart';
import '../../services/notification_services.dart';

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
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: AppColors.grey.withOpacity(0.5)),
          )),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomWidgetSelection(
                title: "Home",
                icon: FontAwesomeIcons.house,
                activeColor: _currentIndex == 0 ? AppColors.primaryColor : AppColors.primaryBlack.withOpacity(0.4),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              CustomWidgetSelection(
                title: "Cart",
                activeColor: _currentIndex == 1 ? AppColors.primaryColor : AppColors.primaryBlack.withOpacity(0.4),
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
                activeColor: _currentIndex == 2 ? AppColors.primaryColor : AppColors.primaryBlack.withOpacity(0.4),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              CustomWidgetSelection(
                title: "Account",
                activeColor: _currentIndex == 3 ? AppColors.primaryColor : AppColors.primaryBlack.withOpacity(0.4),
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

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/change_password/change_password_screen.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/edit_profile/edit_profile_screen.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/widgets/profile_listtile_widget.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/wishlist/my_wishlist.dart';
import 'package:smart_mart_user_side/services/auth_services.dart';
import 'package:smart_mart_user_side/widgets/alert_dilog.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/user_controller.dart';
import 'my_orders/my_orders.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("My Account", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                userController.userModel!.image == ""
                    ? CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.mainColor,
                        child: Center(
                          child: Icon(Icons.person, color: AppColors.primaryWhite),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30,
                        backgroundImage: NetworkImage(userController.userModel!.image!),
                      ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userController.userModel!.username!,
                      style: AppTextStyles().H2.copyWith(fontSize: 16),
                    ),
                    Text(
                      userController.userModel!.email!,
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(color: AppColors.mainColor, thickness: 1.5),
          SizedBox(height: 20),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, MyOrders()),
            icon: Icons.note_alt,
            title: "My Orders",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, MyWishListScreen()),
            icon: Icons.favorite_border,
            title: "Wishlist",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, EditProfileScreen()),
            icon: Icons.person,
            title: "Edit Profile",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, ChangePasswordScreen()),
            icon: Icons.lock_person_outlined,
            title: "Change Password",
          ),
          ProfileListTileWidget(
            onPressed: () {
              customAlertDialogBox(
                  context: context,
                  title: "Wait",
                  content: "Are you sure to logout?",
                  plusBtnClicked: () {
                    AuthServices.signOut(context);
                  },
                  negativeBtnClicked: () {
                    Get.back();
                  });
            },
            icon: Icons.logout,
            title: "LogOut",
          ),
        ],
      ),
    );
  }
}

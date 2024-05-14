import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/address_screen/add_address_screen.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/edit_profile_screen.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/widgets/profile_listtile_widget.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/user_controller.dart';
import 'order_history.dart';

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
                        backgroundColor: AppColors.mainColor.withOpacity(0.5),
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
            onPressed: () => navigateToPageWithPush(context, OrderHistory()),
            icon: FontAwesomeIcons.clockRotateLeft,
            title: "Order History",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, EditProfileScreen()),
            icon: Icons.person,
            title: "Edit Profile",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, AddAddressScreen()),
            icon: Icons.location_on_outlined,
            title: "Add Address",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, OrderHistory()),
            icon: Icons.lock_person_outlined,
            title: "Change Password",
          ),
          ProfileListTileWidget(
            onPressed: () => navigateToPageWithPush(context, OrderHistory()),
            icon: Icons.logout,
            title: "LogOut",
          ),
        ],
      ),
    );
  }
}

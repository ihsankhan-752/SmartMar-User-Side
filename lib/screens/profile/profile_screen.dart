import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/profile/widgets/action_button.dart';
import 'package:smart_mart_user_side/screens/profile/widgets/custom_list_tile.dart';
import 'package:smart_mart_user_side/screens/profile/widgets/profile_listtile_widget.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../constants/app_text.dart';
import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../constants/text_styles.dart';
import '../../controllers/user_controller.dart';
import '../../services/auth_services.dart';
import '../address_screen/add_address_screen.dart';
import '../bottom_nav_bar/cart/cart_screen.dart';
import 'edit_profile_screen.dart';
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
    return Container(
      color: AppColors.primaryBlack,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.mainColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppText.ACCOUNT, style: AppTextStyles.APPBAR_HEADING_STYLE),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                      backgroundImage: NetworkImage(userController.userImage),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.username,
                          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                            fontSize: 18,
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userController.email,
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
                  title: "Order History"),
              // ProfileListTileWidget(
              //     onPressed: () => navigateToPageWithPush(
              //         context,
              //         MyWishListScreen(
              //           wishlist: userController.wishlist,
              //           cartList: userController.cart,
              //         )),
              //     icon: FontAwesomeIcons.heart,
              //     title: "My Wishlist"),
              ProfileListTileWidget(
                  onPressed: () => navigateToPageWithPush(
                      context,
                      CartScreen(
                        pdtIds: userController.cart,
                      )),
                  icon: FontAwesomeIcons.cartShopping,
                  title: "My Cart"),
              Text(
                "-----------Account Info------------",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 300,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        CustomListTile(
                          title: "Email",
                          subTitle: data['email'],
                          icon: Icons.email,
                        ),
                        CustomListTile(
                          title: "Phone Number",
                          subTitle: data['phone'] == "" ? "No Phone Number Found" : data['phone'],
                          icon: Icons.phone,
                        ),
                        CustomListTile(
                          onPressed: data['address'] == ""
                              ? () {
                                  navigateToPageWithPush(context, AddAddressScreen());
                                }
                              : () {},
                          title: "Address",
                          subTitle: data['address'] == "" ? "No Address Found Add?" : data['address'],
                          icon: Icons.location_on,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text(
                "-----------Account Settings------------",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    return CustomListTile(
                      onPressed: () {
                        navigateToPageWithPush(
                            context,
                            EditProfileScreen(
                              data: data,
                            ));
                      },
                      title: "Edit Profile",
                      subTitle: "",
                      icon: Icons.edit,
                    );
                  }),
              CustomListTile(
                title: "Change Password",
                subTitle: "",
                icon: Icons.lock,
              ),
              CustomListTile(
                onPressed: () {
                  StylishDialog(
                    context: context,
                    alertType: StylishDialogType.WARNING,
                    title: Text(
                      'Wait',
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    style: DefaultStyle(
                      backgroundColor: AppColors.mainColor,
                    ),
                    content: Text(
                      'Are you sure to Logout?',
                      style: TextStyle(
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    cancelButton: ActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      actionTitle: "No",
                      btnColor: Colors.red[900],
                    ),
                    confirmButton: ActionButton(
                      onPressed: () async {
                        await AuthServices.signOut(context);
                      },
                      actionTitle: "Yes",
                      btnColor: AppColors.primaryColor,
                    ),
                  ).show();
                },
                title: "Log Out",
                subTitle: "",
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

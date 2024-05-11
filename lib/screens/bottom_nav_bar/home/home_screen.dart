import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/all_categories.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/get_product_by_category.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../controllers/user_controller.dart';
import '../../../widgets/custom_text_fields.dart';
import '../cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tabs = ['All', 'Men', 'Women', 'Kids Wear'];
  int currentIndex = 0;
  String _selectedValue = 'All';
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            "Discover",
            style: GoogleFonts.poppins(
              color: AppColors.primaryBlack,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                navigateToPageWithPush(context, CartScreen(pdtIds: userController.cart));
              },
              child: Icon(Icons.notifications_none, color: AppColors.primaryBlack),
            ),
            SizedBox(width: 15),
          ],
        ),
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      height: 55,
                      child: SearchTextInput(controller: TextEditingController(), hintText: "Search"),
                    ),
                    Container(
                      height: 45,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      child: PopupMenuButton(
                        icon: SizedBox(
                          height: 40,
                          width: 30,
                          child: Image.asset('assets/images/png/filter.png', color: AppColors.primaryWhite),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'all',
                              child: Text("All"),
                              onTap: () {
                                setState(() {
                                  _selectedValue = 'All';
                                });
                              },
                            ),
                            PopupMenuItem(
                              value: 'men',
                              child: Text("Men"),
                              onTap: () {
                                setState(() {
                                  _selectedValue = 'men';
                                });
                              },
                            ),
                            PopupMenuItem(
                              value: 'women',
                              child: Text("Women"),
                              onTap: () {
                                setState(() {
                                  _selectedValue = '=women';
                                });
                              },
                            ),
                            PopupMenuItem(
                              value: 'kids',
                              child: Text("Kids"),
                              onTap: () {
                                setState(() {
                                  _selectedValue = 'kids';
                                });
                              },
                            ),
                          ];
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                if (_selectedValue == 'All') ...{
                  ALlCategories(),
                } else ...{
                  GetProductByCategory(category: _selectedValue)
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}

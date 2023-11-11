import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/lib/utils/functions/functions.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/cart/cart_screen.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/all_categories.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/kids_category.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/men_category.dart';
import 'package:smart_mart_user_side/lib/views/bottom_nav_bar/home/widgets/women_category.dart';

import '../../../controllers/user_controller.dart';
import '../../../custom_widgets/custom_text_fields.dart';
import '../../../utils/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tabs = ['All', 'Men', 'Women', 'Kids Wear'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.primaryBlack,
          title: Text(
            "Hey ${userController.username}",
            style: GoogleFonts.poppins(
              color: AppColors.primaryWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  navigateToPageWithPush(context, CartScreen(pdtIds: userController.cart));
                },
                child: Icon(Icons.shopping_cart)),
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
                Text(
                  "Let's Find your\nExclusive Choice",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                AuthTextInput(controller: TextEditingController(), hintText: "Search"),
                SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: currentIndex == index ? AppColors.primaryColor : AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Text(tabs[index]),
                        ),
                      );
                    },
                  ),
                ),
                if (currentIndex == 0) ALlCategories(),
                if (currentIndex == 1) MenCategory(),
                if (currentIndex == 2) WomenCategory(),
                if (currentIndex == 3) KidsCategory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

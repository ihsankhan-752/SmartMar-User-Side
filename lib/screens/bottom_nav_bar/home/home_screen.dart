import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/constants/lists.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/all_categories.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/get_product_by_category.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/wishlist/my_wishlist.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../widgets/custom_text_fields.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String _selectedValue = 'All';
  @override
  Widget build(BuildContext context) {
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
                navigateToPageWithPush(context, MyWishListScreen());
              },
              child: Icon(Icons.favorite_border, color: AppColors.primaryBlack),
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
                SizedBox(height: 20),
                SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories.map((e) {
                      return GestureDetector(
                        onTap: () {
                          _selectedValue = e;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedValue == e ? AppColors.primaryBlack : AppColors.primaryWhite,
                            border: Border.all(color: _selectedValue == e ? AppColors.primaryBlack : AppColors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: _selectedValue == e ? AppColors.primaryWhite : AppColors.primaryBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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

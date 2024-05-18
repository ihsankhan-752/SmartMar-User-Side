import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/constants/lists.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/home/widgets/get_product_by_category.dart';
import 'package:smart_mart_user_side/screens/chat/user_list_screen.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../widgets/custom_text_fields.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
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
                navigateToPageWithPush(context, UserListScreen());
              },
              child: SizedBox(
                height: 25,
                width: 25,
                child: Image.asset('assets/images/chat.png', fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        extendBody: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 55,
                child: SearchTextInput(
                  controller: _searchController,
                  onCrossIconClick: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  hintText: "Search",
                  onChange: (v) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), child: Image.asset('assets/images/adv.png', fit: BoxFit.cover)),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categories.map((e) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedValue = e;
                        });
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
              GetProductByCategory(category: _selectedValue, searchText: _searchController.text)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/navigations.dart';
import '../../../../address_screen/add_address_screen.dart';

class UserAddressWidget extends StatelessWidget {
  const UserAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context).userModel;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          userController!.address == ""
              ? Center(
                  child: InkWell(
                    onTap: () {
                      navigateToPageWithPush(context, AddAddressScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "Please Enter Your Delivery\nAddress",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name: ${userController.username}",
                          style: AppTextStyles().H2.copyWith(fontSize: 13),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Phone: ${userController.phone}",
                          style: AppTextStyles().H2.copyWith(fontSize: 13),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Address: ${userController.address}",
                          style: AppTextStyles().H2.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/navigations.dart';
import '../../../../address_screen/add_address_screen.dart';

class UserAddressWidget extends StatelessWidget {
  const UserAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.mainColor,
            border: Border.all(color: AppColors.primaryColor)),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return data['address'] == ""
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          navigateToPageWithPush(context, AddAddressScreen());
                        },
                        child: Text(
                          "Please Enter Your Delivery Address",
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name: ${data['userName']}",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Phone: ${data['phone']}",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Address: ${data['address']}",
                            style: TextStyle(
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    );
            }
          },
        ));
  }
}

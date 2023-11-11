import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/lib/views/profile/widgets/action_button.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../custom_widgets/custom_msg.dart';
import '../../../services/firestore_services.dart';
import '../../../utils/functions/functions.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../custom_bottom_navigation_bar.dart';

class MyWishListScreen extends StatelessWidget {
  final List<dynamic> wishlist;
  final List<dynamic> cartList;
  const MyWishListScreen({Key? key, required this.wishlist, required this.cartList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("My Wishlist", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection("products").doc(wishlist[index]).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var data = snapshot.data!.data() as Map<String, dynamic>;
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(data['productImages'][0], fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data['pdtName'],
                                            style: GoogleFonts.acme(
                                              fontSize: 18,
                                              letterSpacing: 0.6,
                                              color: AppColors.primaryWhite,
                                            ),
                                          ),
                                          SizedBox(height: 05),
                                          Text(
                                            "${data['price'].toStringAsFixed(2)} USD",
                                            style: GoogleFonts.acme(
                                              fontSize: 16,
                                              letterSpacing: 0.3,
                                              color: AppColors.primaryWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        children: [
                                          cartList.contains(data['pdtId'])
                                              ? SizedBox()
                                              : IconButton(
                                                  onPressed: () async {
                                                    if (cartList.contains(data['pdtId'])) {
                                                      showCustomMsg(
                                                          context: context, msg: "Item Already Exist in Cart!");
                                                    } else {
                                                      await FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update({
                                                        "cart": FieldValue.arrayUnion([data['pdtId']]),
                                                      });
                                                      await FireStoreServices().myCart(
                                                        context: context,
                                                        productInfo: data,
                                                      );
                                                      showCustomMsg(
                                                          context: context, msg: "Item is Added to Cart Successfully!");

                                                      navigateToPageWithPush(context, CustomBottomNavigation());
                                                    }
                                                  },
                                                  icon: Icon(Icons.shopping_cart, size: 20),
                                                ),
                                          IconButton(
                                            onPressed: () async {
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
                                                  'Are you sure to Remove this Product?',
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
                                                    Navigator.of(context).pop();
                                                    await FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                                        .update({
                                                      "wishlist": FieldValue.arrayRemove([wishlist[index]]),
                                                    });

                                                    showCustomMsg(
                                                        context: context, msg: "Item is Successfully Removed");
                                                    navigateToPageWithPush(context, CustomBottomNavigation());
                                                  },
                                                  actionTitle: "Yes",
                                                  btnColor: AppColors.primaryColor,
                                                ),
                                              ).show();
                                            },
                                            icon: Icon(Icons.delete_forever, color: Colors.red[900], size: 25),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

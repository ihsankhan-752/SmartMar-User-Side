import 'package:badges/badges.dart' as badge;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/lib/views/chat/chat_screen.dart';

import '../../../../../custom_widgets/buttons.dart';
import '../../../../../services/firestore_services.dart';
import '../../../../../utils/functions/functions.dart';
import '../../../../../utils/styles/colors.dart';
import '../../../cart/cart_screen.dart';

class BottomPortion extends StatelessWidget {
  final dynamic productInfo;
  const BottomPortion({Key? key, this.productInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SizedBox(width: 10),
            InkWell(
                onTap: () {
                  navigateToPageWithPush(context, ChatScreen(supplierId: productInfo['supplierId']));
                },
                child: Icon(Icons.chat, color: AppColors.primaryWhite)),
            SizedBox(width: 20),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  return IconButton(
                    icon: badge.Badge(
                      showBadge: data['cart'].length == 0 ? false : true,
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: AppColors.primaryColor,
                      ),
                      badgeContent: Text(
                        data['cart'].length.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Icon(Icons.shopping_cart, color: AppColors.primaryWhite),
                    ),
                    onPressed: () {
                      navigateToPageWithPush(
                        context,
                        CartScreen(
                          pdtIds: data['cart'],
                        ),
                      );
                    },
                  );
                }),
            Spacer(),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.4,
              child: PrimaryButton(
                onTap: () async {
                  await FireStoreServices().addItemToCart(context, productInfo['pdtId']);
                  await FireStoreServices().myCart(context: context, productInfo: productInfo);
                },
                title: "Add To Cart",
              ),
            )
          ],
        ),
      ),
    );
  }
}

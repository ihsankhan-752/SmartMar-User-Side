import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/wishlist/widgets/no_pdt_found_widget.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/wishlist/widgets/wishlist_card_widget.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../controllers/user_controller.dart';
import '../../../../models/pdt_model.dart';

class MyWishListScreen extends StatelessWidget {
  const MyWishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("My Wishlist", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.mainColor)),
      ),
      body: Column(
        children: [
          if (userController.userModel!.wishlist!.isEmpty) ...{
            NoProductFoundInWishlistWidget(),
          } else ...{
            Expanded(
              child: Container(
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: userController.userModel!.wishlist!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .doc(userController.userModel!.wishlist![index])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            ProductModel productModel = ProductModel.fromMap(snapshot.data!);
                            return Slidable(
                              endActionPane: ActionPane(
                                children: [
                                  SlidableAction(
                                    onPressed: (v) async {
                                      print(v);
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .update({
                                        "wishlist": FieldValue.arrayRemove([userController.userModel!.wishlist![index]]),
                                      });
                                    },
                                    backgroundColor: Colors.red.shade500,
                                    borderRadius: BorderRadius.circular(10),
                                    icon: Icons.delete,
                                    label: 'Remove',
                                  ),
                                ],
                                motion: ScrollMotion(),
                              ),
                              child: WishlistCardWidget(productModel: productModel, userController: userController),
                            );
                          },
                        );
                      },
                    )),
              ),
            ),
          }
        ],
      ),
    );
  }
}

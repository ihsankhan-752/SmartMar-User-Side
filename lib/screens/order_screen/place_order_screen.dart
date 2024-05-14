import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/custom_bottom_navigation_bar.dart';

import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_msg.dart';
import '../bottom_nav_bar/home/widgets/place_order_widget/user_address_widget.dart';
import '../payment_screen/payment_screen.dart';

class PlaceOrderScreen extends StatefulWidget {
  final List pdtId;
  final double? total;
  final dynamic supplierId;
  final Map quantity;
  PlaceOrderScreen({Key? key, required this.pdtId, this.total, this.supplierId, required this.quantity}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            widget.pdtId.clear();
            widget.quantity.clear();
            navigateToPageWithPush(context, CustomBottomNavigation());
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Place Order",
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("User Address", style: AppTextStyles().H2.copyWith(fontSize: 16)),
          SizedBox(height: 8),
          UserAddressWidget(),
          SizedBox(height: 20),
          Text("Products to purchase", style: AppTextStyles().H2.copyWith(fontSize: 16)),
          Container(
            height: Get.height * 0.6,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.pdtId.length,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("products").doc(widget.pdtId[index]).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    ProductModel productModel = ProductModel.fromMap(snapshot.data!);
                    int quantity = widget.quantity[productModel.pdtId] ?? 0;

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    productModel.pdtImages![0],
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productModel.pdtName!, style: AppTextStyles().H2.copyWith(fontSize: 16)),
                                Text(productModel.category!,
                                    style: AppTextStyles().H2.copyWith(fontSize: 10, color: AppColors.grey)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "\$${productModel.pdtPrice!.toStringAsFixed(1)}",
                                      style: AppTextStyles().H2.copyWith(fontSize: 14),
                                    ),
                                    SizedBox(width: 10),
                                    Text("x ${quantity.toString()}", style: AppTextStyles().H2.copyWith(fontSize: 12)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
      bottomSheet: Container(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
        child: PrimaryButton(
          onTap: () async {
            DocumentSnapshot snap =
                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
            if (snap['address'] == "") {
              showCustomMsg(context: context, msg: "Set Your Address For Delivery First!!");
            } else {
              navigateToPageWithPush(
                context,
                PaymentScreen(
                  total: widget.total,
                  supplierId: widget.supplierId,
                  pdtIds: widget.pdtId,
                  quantities: widget.quantity.values.toList(),
                ),
              );
            }
          },
          title: "Confirm Payment: ${widget.total} USD",
        ),
      )),
    );
  }
}

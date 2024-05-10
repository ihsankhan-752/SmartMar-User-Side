import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/navigations.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_msg.dart';
import '../bottom_nav_bar/home/widgets/place_order_widget/user_address_widget.dart';
import '../payment_screen/payment_screen.dart';

class PlaceOrderScreen extends StatefulWidget {
  final List pdtId;
  double? total;
  final dynamic supplierId;
  PlaceOrderScreen({Key? key, required this.pdtId, this.total, this.supplierId}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Place Order", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(children: [
        SizedBox(height: 20),
        UserAddressWidget(),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 80),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColor)),
            child: ListView.builder(
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
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 100,
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
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(data['productImages'][0], fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['pdtName'],
                                  style: TextStyle(
                                    color: AppColors.primaryWhite,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "USD ${data['price'].toString()}",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                  ),
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
        ),
      ]),
      bottomSheet: Container(
          height: 70,
          color: AppColors.mainColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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

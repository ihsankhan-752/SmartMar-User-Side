import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/widgets/action_button.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/widgets/order_info_card.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/profile/widgets/order_rating_screen.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../constants/colors.dart';
import '../../../constants/navigations.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/custom_msg.dart';
import '../custom_bottom_navigation_bar.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text("My Orders", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where("customerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Sorry ! No Active Order Found",
                      style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var orderInfo = snapshot.data!.docs[index];

                    return Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ...orderInfo['pdtImages'].map((e) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    height: 100,
                                    width: 120,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15), child: Image.network(e, fit: BoxFit.cover)),
                                  );
                                }).toList(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Names",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 05),
                                    ...orderInfo['pdtName'].map((e) {
                                      return Text(
                                        e,
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Price",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 05),
                                    ...orderInfo['pdtPrice'].map((e) {
                                      return Text(
                                        e.toString() + "USD",
                                        style: TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            orderInfo['orderStatus'] == "deliver" && orderInfo['orderReview'] == false
                                ? InkWell(
                                    onTap: () async {
                                      navigateToPageWithPush(
                                        context,
                                        OrderRatingScreen(
                                          pdtId: orderInfo['pdtIds'],
                                          orderId: orderInfo['orderId'],
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Write Your Review",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primaryWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.grade, color: Colors.amber),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      orderInfo['orderStatus'] == 'deliver'
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Text("Order Done"),
                                            )
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
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
                                                    'Are you sure to cancel your order?',
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
                                                          .collection("orders")
                                                          .doc(orderInfo.id)
                                                          .delete();

                                                      showCustomMsg(context: context, msg: "Item is Successfully Removed");
                                                      navigateToPageWithPush(context, CustomBottomNavigation());
                                                    },
                                                    actionTitle: "Yes",
                                                    btnColor: AppColors.primaryColor,
                                                  ),
                                                ).show();
                                              },
                                              child: Text("Cancel Order"),
                                            ),
                                      SizedBox(width: 40),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff1D2221),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor: AppColors.mainColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(25),
                                                  topLeft: Radius.circular(25),
                                                )),
                                                context: context,
                                                builder: (_) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Order Information",
                                                          style: TextStyle(
                                                            color: AppColors.primaryColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        SizedBox(height: 08),
                                                        OrderInfoCard(title: "Name", value: orderInfo['customerName']),
                                                        OrderInfoCard(title: "Phone", value: orderInfo['customerPhone']),
                                                        OrderInfoCard(title: "Email", value: orderInfo['customerEmail']),
                                                        OrderInfoCard(title: "Address", value: orderInfo['customerAddress']),
                                                        OrderInfoCard(title: "Payment Status", value: orderInfo['paymentStatus']),
                                                        OrderInfoCard(title: "Order Status", value: orderInfo['orderStatus']),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Text("View Details")),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

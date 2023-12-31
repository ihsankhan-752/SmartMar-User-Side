import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smart_mart_user_side/lib/services/notification_services.dart';
import 'package:smart_mart_user_side/lib/views/payment_screen/widgets/payment_and_shipment_widget.dart';
import 'package:uuid/uuid.dart';

import '../../custom_widgets/buttons.dart';
import '../../custom_widgets/custom_msg.dart';
import '../../utils/functions/functions.dart';
import '../../utils/services/stripe_services.dart';
import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';
import '../bottom_nav_bar/custom_bottom_navigation_bar.dart';

class PaymentScreen extends StatefulWidget {
  double? total;
  final String? supplierId;
  final List<dynamic>? pdtIds;
  PaymentScreen({Key? key, this.total, this.supplierId, this.pdtIds}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  int _groupValue = 1;
  List pdtName = [];
  List pdtImages = [];
  List pdtPrices = [];
  List pdtIds = [];
  int? pdtQuantity;
  @override
  Widget build(BuildContext context) {
    print(widget.pdtIds);
    double orderTotal = widget.total! - 10.0;
    double shipmentCost = 10.0;

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Payment Screen", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Material(
              child: Center(
                child: Text("SomeThing went wrong!"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                SizedBox(height: 20),
                PaymentAndShipmentWidget(
                  total: widget.total!,
                  shipmentCost: shipmentCost,
                  orderTotal: orderTotal,
                ),
                SizedBox(height: 20),
                // PaymentMethodSelectionWidget(groupValue: _groupValue),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.mainColor,
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        activeColor: AppColors.primaryColor,
                        value: 1,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text(
                          "Cash On Delivery",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Pay at Home",
                          style: TextStyle(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      RadioListTile(
                        activeColor: AppColors.primaryColor,
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text(
                          "Pay via Visa/ Master Card",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(FontAwesomeIcons.ccMastercard, color: Colors.blue),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: PrimaryButton(
                    onTap: () async {
                      if (_groupValue == 1) {
                        showModalBottomSheet(
                            backgroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                            context: context,
                            builder: (_) {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pay At Home ${widget.total}",
                                      style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                        color: Colors.blueGrey,
                                        fontSize: 20,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: PrimaryButton(
                                        onTap: () async {
                                          for (var id in widget.pdtIds!) {
                                            DocumentSnapshot pdtSnap =
                                                await FirebaseFirestore.instance.collection("products").doc(id).get();
                                            setState(() {
                                              pdtName.add(pdtSnap['pdtName']);
                                              pdtImages.add(pdtSnap['productImages'][0]);
                                              pdtPrices.add(pdtSnap['price']);
                                              pdtIds.add(id);
                                              widget.total = 0.0;
                                            });
                                          }

                                          DocumentSnapshot userData = await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .get();
                                          DocumentSnapshot supplierData = await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.supplierId)
                                              .get();
                                          var orderId = Uuid().v1();
                                          try {
                                            await FirebaseFirestore.instance.collection("orders").doc(orderId).set({
                                              "customerId": FirebaseAuth.instance.currentUser!.uid,
                                              "customerName": userData['userName'],
                                              "customerImage": userData['image'],
                                              "customerEmail": userData['email'],
                                              "customerAddress": userData["address"],
                                              "customerPhone": userData['phone'],
                                              "supplierId": supplierData['uid'],
                                              "supplierName": supplierData['userName'],
                                              "supplierImage": supplierData['image'],
                                              "supplierContact": supplierData['phone'],
                                              "orderId": orderId,
                                              "pdtName": FieldValue.arrayUnion(pdtName),
                                              "pdtImages": FieldValue.arrayUnion(pdtImages),
                                              "pdtPrice": FieldValue.arrayUnion(pdtPrices),
                                              "pdtIds": FieldValue.arrayUnion(pdtIds),
                                              "orderPrice": widget.total,
                                              "orderStatus": "preparing",
                                              "deliveryDate": "",
                                              "orderDate": DateTime.now(),
                                              'paymentStatus': "cash on delivery",
                                              "orderReview": false,
                                              "orderQuantity": pdtQuantity,
                                            });
                                            navigateToPageWithPush(context, CustomBottomNavigation());
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                .update({
                                              "cart": [],
                                            });
                                            QuerySnapshot cartSnap = await FirebaseFirestore.instance
                                                .collection('mycart')
                                                .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                                                .get();

                                            for (var i in cartSnap.docs) {
                                              i.reference.delete();
                                            }
                                            await NotificationServices().sendPushNotification(
                                              widget.supplierId!,
                                              'Order Notification',
                                              'You Received an Order from ${userData['userName']}',
                                            );
                                            await NotificationServices().addNotificationInDB(
                                              supplierId: widget.supplierId!,
                                              title: 'Your Received a new Order',
                                            );

                                            setState(() {
                                              widget.total = 0.0;
                                              pdtQuantity = 0;
                                              widget.total = 0.0;
                                            });
                                          } catch (e) {
                                            print(e);
                                            showCustomMsg(context: context, msg: e.toString());
                                          }
                                        },
                                        title: "Confirm ${widget.total}",
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else if (_groupValue == 2) {
                        // makePaymentWithCard(context);
                        for (var id in widget.pdtIds!) {
                          QuerySnapshot cartSnap = await FirebaseFirestore.instance
                              .collection("mycart")
                              .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                              .get();
                          for (var ids in cartSnap.docs) {
                            pdtQuantity = ids['quantity'];
                            print(pdtQuantity);
                          }
                          DocumentSnapshot pdtSnap =
                              await FirebaseFirestore.instance.collection("products").doc(id).get();
                          setState(() {
                            pdtName.add(pdtSnap['pdtName']);
                            pdtImages.add(pdtSnap['productImages'][0]);
                            pdtPrices.add(pdtSnap['price']);
                            pdtIds.add(id);
                          });
                        }

                        DocumentSnapshot userData = await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                        DocumentSnapshot supplierData =
                            await FirebaseFirestore.instance.collection("users").doc(widget.supplierId).get();
                        String orderId = Uuid().v1();
                        await makePayment(
                          orderData: {
                            "customerId": FirebaseAuth.instance.currentUser!.uid,
                            "customerName": userData['userName'],
                            "customerImage": userData['image'],
                            "customerEmail": userData['email'],
                            "customerAddress": userData["address"],
                            "customerPhone": userData['phone'],
                            "supplierId": supplierData['uid'],
                            "supplierName": supplierData['userName'],
                            "supplierImage": supplierData['image'],
                            "supplierContact": supplierData['phone'],
                            "orderId": orderId,
                            "pdtName": FieldValue.arrayUnion(pdtName),
                            "pdtImages": FieldValue.arrayUnion(pdtImages),
                            "pdtPrice": FieldValue.arrayUnion(pdtPrices),
                            "pdtIds": FieldValue.arrayUnion(pdtIds),
                            "orderPrice": widget.total,
                            "orderStatus": "preparing",
                            "deliveryDate": "",
                            "orderDate": DateTime.now(),
                            'paymentStatus': "card",
                            "orderReview": false,
                            "orderQuantity": pdtQuantity,
                          },
                          orderId: orderId,
                          amount: "10000",
                        );
                        setState(() {
                          widget.total = 0.0;
                        });
                      } else {
                        return null;
                      }
                    },
                    title: "Confirm ${widget.total} USD",
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          } else {
            return Center(
              child: SizedBox(),
            );
          }
        },
      ),
    );
  }

  Future<void> makePayment({Map<String, dynamic>? orderData, String? orderId, String? amount}) async {
    try {
      paymentIntent = await createPaymentIntent(amount!, 'USD');

      var gpay = PaymentSheetGooglePay(merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ihsan',
                  googlePay: gpay))
          .then((value) async {
        await FirebaseFirestore.instance.collection("orders").doc(orderId).set(orderData!);
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "cart": [],
        });
        setState(() {
          widget.total = 0.0;
        });
      });

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showCustomMsg(context: context, msg: "Transaction Successfully Done!");
        navigateToPageWithPush(context, CustomBottomNavigation());
      });
    } catch (e) {
      print('$e');
    }
  }

//Step 1
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer $stripeSecretKey', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

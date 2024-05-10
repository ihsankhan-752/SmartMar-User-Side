// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'package:sn_progress_dialog/progress_dialog.dart';
//
// import '../../../utils/services/stripe_services.dart';
//
// late String orderId;
// void showProgress(BuildContext context) {
//   ProgressDialog progress = ProgressDialog(context: context);
//   progress.show(max: 100, msg: "Please wait..", progressBgColor: Colors.red);
// }
//
// Map<String, dynamic>? paymentIntentData;
// Future<void> makePaymentWithCard(BuildContext context) async {
//   try {
//     paymentIntentData = await createPaymentIntents();
//     await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//       paymentIntentClientSecret: paymentIntentData!["client_secret"],
//       applePay: true,
//       googlePay: true,
//       testEnv: true,
//       merchantDisplayName: "Annie",
//       merchantCountryCode: "US",
//     ));
//     await displayPaymentSheet(context);
//   } catch (e) {
//     print(e);
//   }
// }
//
// createPaymentIntents() async {
//   try {
//     Map<String, dynamic> body = {
//       "amount": "10",
//       "currency": "USD",
//       "payment_method_types[]": "card",
//     };
//     var response = await http
//         .post(Uri.parse("https://api.stripe.com/v1/payment_intents"), body: body, headers: {
//       "Authorization": "Bearer $stripeSecretKey",
//       "content_type": "application/x-www-form-urlencoded",
//     });
//     return jsonDecode(response.body);
//   } catch (e) {
//     print(e);
//   }
// }
//
// displayPaymentSheet(BuildContext context) async {
//   try {
//     await Stripe.instance.presentPaymentSheet(
//         parameters: PresentPaymentSheetParameters(
//       clientSecret: paymentIntentData!["client_secret"],
//       confirmPayment: true,
//     ));
//   } catch (e) {
//     print(e.toString());
//   }
//   //       .then((value) async {
//   //     paymentIntentData = null;
//   //     showProgress(context);
//   //     //
//   //     // orderId = Uuid().v4();
//   //     // CollectionReference orderRef = FirebaseFirestore.instance.collection("orders");
//   //     // await orderRef
//   //     //     .doc(orderId)
//   //     //     .set(data
//   //             // "customerId": FirebaseAuth.instance.currentUser!.uid,
//   //             // "customerName": data['customerName'],
//   //             // "customerImage": data['image'],
//   //             // "customerEmail": data['email'],
//   //             // "customerAddress": data["address"],
//   //             // "customerPhone": data['phone'],
//   //             // "supplierId": item.supplierId,
//   //             // "orderId": orderId,
//   //             // "productId": item.docId,
//   //             // "orderName": item.name,
//   //             // "orderImage": item.imageUrl.first,
//   //             // "orderQuantity": item.quantity,
//   //             // "orderPrice": item.quantity * item.price,
//   //             // "orderStatus": "preparing",
//   //             // "deliveryDate": "",
//   //             // "orderDate": DateTime.now(),
//   //             // 'paymentStatus': "card",
//   //             // "orderReview": false,
//   //         //     )
//   //         // .whenComplete(() async {
//   //       // await FirebaseFirestore.instance.runTransaction((transaction) async {
//   //       //   DocumentReference documentReference =
//   //       //       FirebaseFirestore.instance.collection("products").doc(pdtId);
//   //       //   DocumentSnapshot snap = await transaction.get(documentReference);
//   //       //   transaction.update(
//   //       //     documentReference,
//   //       //     {
//   //       //       "quantity": snap['quantity'] - 1,
//   //       //     },
//   //       //   );
//   //       // });
//   //     });
//   //   });
//   //   Navigator.push(context, MaterialPageRoute(builder: (_) => CustomBottomNavigation()));
//   // } catch (e) {
//   //   print(e);
//   // }
// }

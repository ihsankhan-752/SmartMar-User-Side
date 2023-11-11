// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:superstore_app/custom_widgets/buttons.dart';
// import 'package:superstore_app/custom_widgets/custom_msg.dart';
// import 'package:superstore_app/utils/styles/text_styles.dart';
// import 'package:superstore_app/views/payment_screen/widgets/payment_through_stripe.dart';
// import 'package:uuid/uuid.dart';
//
// orderPlacementConditions({BuildContext? context, int? groupVal, dynamic data}) async {
//   if (groupVal == 1) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         )),
//         context: context!,
//         builder: (_) {
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.3,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Pay At Home $data",
//                   style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
//                     color: Colors.blueGrey,
//                     fontSize: 20,
//                     letterSpacing: 0.5,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: PrimaryButton(
//                     onTap: () async {
//                       // cashOnDelivery(context, data);
//                       var orderId = Uuid().v1();
//                       try {
//                         await FirebaseFirestore.instance.collection("orders").doc(orderId).set({
//                           "customerId": FirebaseAuth.instance.currentUser!.uid,
//                           "customerName": data['customerName'],
//                           "customerImage": data['image'],
//                           "customerEmail": data['email'],
//                           "customerAddress": data["address"],
//                           "customerPhone": data['phone'],
//                           // "supplierId": item.supplierId,
//                           "orderId": orderId,
//                           // "productId": item.docId,
//                           // "orderName": item.name,
//                           // "orderImage": item.imageUrl.first,
//                           // "orderQuantity": item.quantity,
//                           // "orderPrice": item.quantity * item.price,
//                           "orderStatus": "preparing",
//                           "deliveryDate": "",
//                           "orderDate": DateTime.now(),
//                           'paymentStatus': "cash on delivery",
//                           "orderReview": false,
//                         });
//                       } catch (e) {
//                         showCustomMsg(context: context, msg: e.toString());
//                       }
//                     },
//                     title: "Confirm $data",
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   } else if (groupVal == 2) {
//     double totalAmount = data + 10.0;
//     int payment = totalAmount.round();
//     int pay = payment * 100;
//
//     await makePaymentWithCard(data, pay.toString(), context!);
//   }
// }

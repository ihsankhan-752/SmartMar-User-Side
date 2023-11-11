// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sn_progress_dialog/progress_dialog.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../../controllers/cart_controller.dart';
// import '../../custom_bottom_navigation_bar.dart';
//
// Future<void> cashOnDelivery(BuildContext context, dynamic data) async {
//   void showProgress() {
//     ProgressDialog progress = ProgressDialog(context: context);
//     progress.show(max: 100, msg: "Please wait..", progressBgColor: Colors.red);
//   }
//
//   late String orderId;
//   Navigator.of(context).pop();
//   try {
//     showProgress();
//
//     CollectionReference orderRef = FirebaseFirestore.instance.collection("orders");
//     orderId = Uuid().v4();
//     await orderRef.doc(orderId).set({
//       "customerId": FirebaseAuth.instance.currentUser!.uid,
//       "customerName": data['customerName'],
//       "customerImage": data['image'],
//       "customerEmail": data['email'],
//       "customerAddress": data["address"],
//       "customerPhone": data['phone'],
//       "supplierId": item.supplierId,
//       "orderId": orderId,
//       "productId": item.docId,
//       "orderName": item.name,
//       "orderImage": item.imageUrl.first,
//       "orderQuantity": item.quantity,
//       "orderPrice": item.quantity * item.price,
//       "orderStatus": "preparing",
//       "deliveryDate": "",
//       "orderDate": DateTime.now(),
//       'paymentStatus': "cash on delivery",
//       "orderReview": false,
//     }).whenComplete(() async {
//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         DocumentReference documentReference =
//             FirebaseFirestore.instance.collection("products").doc(item.docId);
//         DocumentSnapshot snap = await transaction.get(documentReference);
//         transaction.update(
//           documentReference,
//           {
//             "quantity": snap['quantity'] - 1,
//           },
//         );
//       });
//     });
//
//     Navigator.push(context, MaterialPageRoute(builder: (_) => CustomBottomNavigation()));
//   } catch (e) {
//     print(e);
//   }
// }

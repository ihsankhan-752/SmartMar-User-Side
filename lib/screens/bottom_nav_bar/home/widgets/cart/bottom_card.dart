import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/navigations.dart';
import '../../../../../widgets/buttons.dart';
import '../../../../order_screen/place_order_screen.dart';

class BottomCard extends StatefulWidget {
  final dynamic pdtId;
  const BottomCard({Key? key, this.pdtId}) : super(key: key);

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("mycart")
                  .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                double total = 0.0;
                for (var item in snapshot.data!.docs) {
                  var price = item['price'];
                  var quantity = item['quantity'];
                  total += price * quantity;
                }
                String? supplierId;
                for (var item in snapshot.data!.docs) {
                  supplierId = item['supplierId'];
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: PrimaryButton(
                    onTap: () async {
                      navigateToPageWithPush(
                        context,
                        PlaceOrderScreen(
                          pdtId: widget.pdtId,
                          total: total,
                          supplierId: supplierId,
                        ),
                      );
                    },
                    title: "Total: \$ ${total.toStringAsFixed(1)} Proceed To CheckOut",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

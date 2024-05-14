import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/widgets/custom_msg.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/navigations.dart';
import '../../../../../widgets/buttons.dart';
import '../../../../order_screen/place_order_screen.dart';

class BottomCard extends StatefulWidget {
  const BottomCard({Key? key}) : super(key: key);

  @override
  State<BottomCard> createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  List pdtIds = [];
  Map<String, int> quantitiesMap = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("cart")
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
                  quantitiesMap[item['pdtId']] = quantity;

                  if (!pdtIds.contains(item.id)) {
                    pdtIds.add(item.id);
                  }
                }
                String? supplierId;
                for (var item in snapshot.data!.docs) {
                  supplierId = item['supplierId'];
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: PrimaryButton(
                    onTap: () async {
                      if (total == 0.0) {
                        showCustomMsg(context: context, msg: "No Item in Cart found");
                      } else {
                        navigateToPageWithPush(
                          context,
                          PlaceOrderScreen(
                            pdtId: pdtIds,
                            total: total,
                            supplierId: supplierId,
                            quantity: quantitiesMap,
                          ),
                        );
                      }
                    },
                    title: "Total: \$ ${total.toStringAsFixed(1)} Go To CheckOut",
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

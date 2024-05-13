import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_styles.dart';
import '../../../../models/cart_model.dart';
import '../../../../models/pdt_model.dart';
import '../../../../services/cart_services.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/custom_msg.dart';

class CartProductQuantityIncrementDecrementPortion extends StatelessWidget {
  final ProductModel productModel;
  final String pdtId;
  const CartProductQuantityIncrementDecrementPortion({super.key, required this.productModel, required this.pdtId});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').doc(pdtId).snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return SizedBox();
            }
            CartModel cartModel = CartModel.fromMap(snap.data!);
            return Row(
              children: [
                IncrementDecrementButton(
                  onPressed: () {
                    setState(() {
                      if (cartModel.quantity! <= 1) {
                        showCustomMsg(context: context, msg: "At least one quantity will be present");
                      } else {
                        CartServices().incrementDecrementPdtQuantity(
                          context,
                          productModel.pdtId!,
                          cartModel.quantity! - 1,
                        );
                      }
                    });
                  },
                  icon: Icons.remove,
                ),
                SizedBox(width: 08),
                Text(cartModel.quantity.toString(), style: AppTextStyles().H2.copyWith(fontSize: 14)),
                SizedBox(width: 08),
                IncrementDecrementButton(
                  onPressed: () {
                    setState(() {
                      CartServices().incrementDecrementPdtQuantity(
                        context,
                        productModel.pdtId!,
                        cartModel.quantity! + 1,
                      );
                    });
                  },
                  icon: Icons.add,
                ),
              ],
            );
          });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/services/cart_services.dart';

import '../../../../../constants/colors.dart';
import '../../../../../widgets/buttons.dart';

class BottomPortion extends StatelessWidget {
  final ProductModel productModel;
  const BottomPortion({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: AppColors.grey),
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\$ ${productModel.pdtPrice!.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.6,
              child: PrimaryButton(
                onTap: () async {
                  await CartServices().addItemToCart(context, productModel.pdtId!);
                  await CartServices().myCart(context: context, productModel: productModel);
                },
                title: "Add To Cart",
              ),
            )
          ],
        ),
      ),
    );
  }
}

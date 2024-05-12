import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../controllers/user_controller.dart';
import '../../../../models/pdt_model.dart';
import 'cart_status_widget.dart';

class WishlistCardWidget extends StatelessWidget {
  final ProductModel productModel;
  final UserController userController;
  const WishlistCardWidget({super.key, required this.productModel, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(productModel.pdtImages![0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.pdtName!,
                    style: AppTextStyles().H2.copyWith(fontSize: 16, color: AppColors.primaryBlack),
                  ),
                  Text(
                    productModel.category!,
                    style: AppTextStyles().H2.copyWith(color: AppColors.grey, fontSize: 10),
                  ),
                  SizedBox(height: 05),
                  Text(
                    "\$ ${productModel.pdtPrice!.toStringAsFixed(2)}",
                    style: AppTextStyles().H2.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
            Spacer(),
            CartStatusWidget(userController: userController, productModel: productModel),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/constants/colors.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';
import 'package:smart_mart_user_side/services/cart_services.dart';

import '../../../../../controllers/user_controller.dart';
import '../../../../../models/pdt_model.dart';

class CartStatusWidget extends StatelessWidget {
  final UserController userController;
  final ProductModel productModel;
  const CartStatusWidget({super.key, required this.userController, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: userController.userModel!.cart!.contains(productModel.pdtId)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 05),
              child: Row(
                children: [
                  Text("In Cart", style: AppTextStyles().H2.copyWith(color: AppColors.grey, fontSize: 14)),
                  SizedBox(width: 05),
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.mainColor,
                    size: 15,
                  ),
                ],
              ),
            )
          : IconButton(
              onPressed: () async {
                CartServices.addItemToCartFromWishList(
                  context: context,
                  userController: userController,
                  productModel: productModel,
                );
              },
              icon: Icon(Icons.shopping_cart, size: 20),
            ),
    );
  }
}

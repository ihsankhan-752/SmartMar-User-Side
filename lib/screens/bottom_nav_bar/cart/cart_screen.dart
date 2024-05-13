import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/cart/widgets/cart_product_image_portion.dart';
import 'package:smart_mart_user_side/screens/bottom_nav_bar/cart/widgets/cart_product_name_and_price_portion.dart';
import 'package:smart_mart_user_side/services/cart_services.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/buttons.dart';
import '../home/widgets/cart/bottom_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("My Cart", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: userController.userModel!.cart!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100, width: 120, child: Image.asset('assets/images/empty_cart.png')),
                  SizedBox(height: 10),
                  Text("Your Cart is Empty", style: AppTextStyles().H2.copyWith(fontSize: 16)),
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: userController.userModel!.cart!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey.withOpacity(0.4), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: Get.height * 0.12,
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(userController.userModel!.cart![index])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        ProductModel productModel = ProductModel.fromMap(snapshot.data!);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CartProductImagePortion(productModel: productModel),
                              SizedBox(width: 10),
                              CartProductNameAndPricePortion(productModel: productModel),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        CartServices.removeItemFromCart(productModel.pdtId!);
                                      },
                                      child: Icon(Icons.close, size: 20, color: AppColors.grey),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        IncrementDecrementButton(
                                          onPressed: () {},
                                          icon: Icons.remove,
                                        ),
                                        SizedBox(width: 08),
                                        Text("2", style: AppTextStyles().H2.copyWith(fontSize: 14)),
                                        SizedBox(width: 08),
                                        IncrementDecrementButton(
                                          onPressed: () {},
                                          icon: Icons.add,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      bottomSheet: BottomCard(
        userController: userController,
      ),
    );
  }
}

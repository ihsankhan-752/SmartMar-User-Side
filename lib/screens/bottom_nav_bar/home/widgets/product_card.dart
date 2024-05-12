import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/navigations.dart';
import '../../../../models/pdt_model.dart';
import '../product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;

  const ProductCard({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPageWithPush(context, ProductDetailScreen(productModel: widget.productModel));
      },
      child: Card(
        color: AppColors.primaryWhite,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: Get.width,
              height: Get.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.productModel.pdtImages![0],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 5, bottom: 3),
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Icon(Icons.grade, color: Colors.amber, size: 12),
                        SizedBox(width: 2),
                        Text(
                          '4.9',
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productModel.pdtName!,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ ${widget.productModel.pdtPrice!.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 05),
          ],
        ),
      ),
    );
  }
}

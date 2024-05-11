import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/navigations.dart';
import '../../../../models/pdt_model.dart';
import '../pdt_detail_screen.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppColors.primaryWhite,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            elevation: 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: Get.width,
              height: Get.height * 0.12,
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
                alignment: Alignment.topRight,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Icon(Icons.favorite_border, size: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  widget.productModel.pdtName!,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.grade, color: Colors.amber, size: 18),
                SizedBox(width: 2),
                Text(
                  '4.9',
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '\$ ${widget.productModel.pdtPrice!.toStringAsFixed(1)}',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

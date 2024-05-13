import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../models/pdt_model.dart';

class CartProductNameAndPricePortion extends StatelessWidget {
  final ProductModel productModel;
  const CartProductNameAndPricePortion({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productModel.pdtName!,
            style: AppTextStyles().H2.copyWith(fontSize: 16),
          ),
          Text(
            productModel.category!,
            style: AppTextStyles().H2.copyWith(fontSize: 12, color: AppColors.grey),
          ),
          Spacer(),
          Text(
            "\$ ${productModel.pdtPrice!.toStringAsFixed(1)}",
            style: AppTextStyles().H2.copyWith(fontSize: 14, color: AppColors.primaryBlack),
          )
        ],
      ),
    );
  }
}

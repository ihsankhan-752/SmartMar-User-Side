import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/pdt_model.dart';

class CartProductImagePortion extends StatelessWidget {
  final ProductModel productModel;
  const CartProductImagePortion({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.09,
      width: Get.width * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          productModel.pdtImages![0],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

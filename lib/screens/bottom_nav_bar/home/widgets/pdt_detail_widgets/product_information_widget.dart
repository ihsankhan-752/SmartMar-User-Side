import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';

import '../../../../../constants/colors.dart';

class ProductInformationWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductInformationWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductInformationWidget> createState() => _ProductInformationWidgetState();
}

class _ProductInformationWidgetState extends State<ProductInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                widget.productModel.pdtName!,
                style: GoogleFonts.acme(
                  textStyle: TextStyle(
                    fontSize: 22,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.grade, size: 25, color: AppColors.amber),
              SizedBox(width: 05),
              Text(
                "4.5/5 (45 reviews)",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            "${widget.productModel.pdtDescription}",
            style: TextStyle(
              color: AppColors.primaryBlack.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

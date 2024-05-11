import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/models/pdt_model.dart';

import '../../../../../constants/text_styles.dart';

class ItemDescWidgetProductDetail extends StatelessWidget {
  final ProductModel productModel;
  const ItemDescWidgetProductDetail({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("Item Description", style: AppTextStyles.APPBAR_HEADING_STYLE),
        SizedBox(height: 10),
        Text(
          productModel.pdtDescription!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

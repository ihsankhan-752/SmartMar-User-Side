import 'package:flutter/material.dart';

import '../../../../../utils/styles/text_styles.dart';

class ItemDescWidgetProductDetail extends StatelessWidget {
  final dynamic data;
  const ItemDescWidgetProductDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("Item Description", style: AppTextStyles.APPBAR_HEADING_STYLE),
        SizedBox(height: 10),
        Text(
          data['pdtDescription']!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

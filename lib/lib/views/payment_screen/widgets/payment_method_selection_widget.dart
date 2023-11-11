import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/styles/colors.dart';

class PaymentMethodSelectionWidget extends StatefulWidget {
  int groupValue;
  PaymentMethodSelectionWidget({Key? key, required this.groupValue}) : super(key: key);

  @override
  State<PaymentMethodSelectionWidget> createState() => _PaymentMethodSelectionWidgetState();
}

class _PaymentMethodSelectionWidgetState extends State<PaymentMethodSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryWhite,
      ),
      child: Column(
        children: [
          RadioListTile(
            value: 1,
            groupValue: widget.groupValue,
            onChanged: (v) {
              setState(() {
                widget.groupValue = int.parse(v.toString());
              });
            },
            title: Text("Cash On Delivery"),
            subtitle: Text("Pay at Home"),
          ),
          RadioListTile(
            value: 2,
            groupValue: widget.groupValue,
            onChanged: (v) {
              setState(() {
                widget.groupValue = int.parse(v.toString());
              });
            },
            title: Text("Pay via Visa/ Master Card"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FontAwesomeIcons.ccMastercard, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

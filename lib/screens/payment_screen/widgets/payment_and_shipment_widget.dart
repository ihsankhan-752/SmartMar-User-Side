import 'package:flutter/material.dart';
import 'package:smart_mart_user_side/constants/text_styles.dart';

import '../../../constants/colors.dart';

class PaymentAndShipmentWidget extends StatelessWidget {
  final double total, shipmentCost, orderTotal;
  const PaymentAndShipmentWidget({Key? key, required this.total, required this.shipmentCost, required this.orderTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "OrderTotal : \$ ${orderTotal.toStringAsFixed(1)} ",
                    style: AppTextStyles().H2.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Shipment Charges : \$ ${shipmentCost.toStringAsFixed(1)}",
                    style: AppTextStyles().H2.copyWith(fontSize: 14),
                  ),
                  Divider(),
                  Text(
                    "Total : \$ ${total}",
                    style: AppTextStyles().H2.copyWith(fontSize: 16),
                  ),
                ],
              ),
            )),
        SizedBox(height: 20),
      ],
    );
  }
}

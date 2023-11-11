import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';

class PaymentAndShipmentWidget extends StatelessWidget {
  final double total, shipmentCost, orderTotal;
  const PaymentAndShipmentWidget({Key? key, required this.total, required this.shipmentCost, required this.orderTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.mainColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total :${total}",
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(thickness: 1, color: AppColors.primaryColor),
                  SizedBox(height: 10),
                  Text(
                    "OrderTotal : ${orderTotal.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Shipment :${shipmentCost.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: 20),
      ],
    );
  }
}

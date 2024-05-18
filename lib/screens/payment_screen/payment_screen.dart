import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:smart_mart_user_side/screens/payment_screen/widgets/payment_and_shipment_widget.dart';
import 'package:smart_mart_user_side/services/order_services.dart';
import 'package:smart_mart_user_side/services/stripe_services.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../widgets/buttons.dart';

class PaymentScreen extends StatefulWidget {
  double? total;
  final String? supplierId;
  final List<dynamic>? pdtIds;
  final List quantities;
  PaymentScreen({Key? key, this.total, this.supplierId, this.pdtIds, required this.quantities}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _groupValue = 1;
  PaymobResponse? response;

  @override
  Widget build(BuildContext context) {
    double orderTotal = widget.total! - 10.0;
    double shipmentCost = 10.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment Screen", style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(color: AppColors.primaryBlack)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Payment Details",
              style: AppTextStyles().H2.copyWith(fontSize: 18),
            ),
            SizedBox(height: 5),
            PaymentAndShipmentWidget(
              total: widget.total!,
              shipmentCost: shipmentCost,
              orderTotal: orderTotal,
            ),
            SizedBox(height: 20),
            Text(
              "Payment Methods",
              style: AppTextStyles().H2.copyWith(fontSize: 18),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (v) {
                      setState(() {
                        _groupValue = v!;
                      });
                    },
                    title: Text(
                      "Cash On Delivery",
                      style: AppTextStyles().H2.copyWith(fontSize: 16),
                    ),
                    subtitle: Text(
                      "Pay at Home",
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    value: 2,
                    groupValue: _groupValue,
                    onChanged: (v) {
                      setState(() {
                        _groupValue = int.parse(v.toString());
                      });
                    },
                    title: Text(
                      "Pay via Visa/ Master Card",
                      style: AppTextStyles().H2.copyWith(fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(FontAwesomeIcons.ccMastercard, color: AppColors.primaryColor),
                      ],
                    ),
                  ),
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    value: 3,
                    groupValue: _groupValue,
                    onChanged: (v) {
                      setState(() {
                        _groupValue = int.parse(v.toString());
                      });
                    },
                    title: Text(
                      "Pay via Paymbob",
                      style: AppTextStyles().H2.copyWith(fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20, width: 80, child: Image.network('https://paymob.pk/images/paymobLogo.png')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(10),
              child: PrimaryButton(
                onTap: () async {
                  if (_groupValue == 1) {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (_) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pay At Home ${widget.total}",
                                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: PrimaryButton(
                                    onTap: () {
                                      OrderServices().makeOrder(
                                        context: context,
                                        productIds: widget.pdtIds!,
                                        totalPrice: widget.total!,
                                        quantities: widget.quantities,
                                        sellerId: widget.supplierId!,
                                        paymentStatus: "COD",
                                      );
                                      setState(() {
                                        widget.total = 0.0;
                                      });
                                    },
                                    title: "Confirm ${widget.total}",
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                  if (_groupValue == 2) {
                    StripePaymentServices()
                        .makePayment(
                      context: context,
                      pdtIds: widget.pdtIds!,
                      quantities: widget.quantities,
                      total: widget.total!,
                      supplierId: widget.supplierId!,
                      amount: "10000",
                    )
                        .then((value) {
                      setState(() {
                        widget.total = 0.0;
                      });
                    });
                  }
                  //
                  // if (_groupValue == 3) {
                  //   try {
                  //     PaymentInitializationResult response = await PaymobPakistan.instance.initializePayment(
                  //       currency: "PKR",
                  //       amountInCents: "100",
                  //     );
                  //
                  //     String authToken = response.authToken;
                  //     int orderID = response.orderID;
                  //
                  //     PaymobPakistan.instance.makePayment(
                  //       context,
                  //       currency: "PKR",
                  //       amountInCents: "100",
                  //       paymentType: PaymentType.card,
                  //       authToken: authToken,
                  //       orderID: orderID,
                  //       onPayment: (response) {
                  //         setState(() {
                  //           this.response = response;
                  //         });
                  //
                  //         OrderServices().makeOrder(
                  //           context: context,
                  //           productIds: widget.pdtIds!,
                  //           totalPrice: widget.total!,
                  //           quantities: widget.quantities,
                  //           sellerId: widget.supplierId!,
                  //           paymentStatus: "Card",
                  //         );
                  //         setState(() {
                  //           widget.total = 0.0;
                  //         });
                  //
                  //         Navigator.pop(context);
                  //       },
                  //     );
                  //   } catch (err) {
                  //     rethrow;
                  //   }
                  // }
                },
                title: "Confirm ${widget.total} USD",
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../constants/keys.dart';
import '../constants/navigations.dart';
import '../screens/bottom_nav_bar/custom_bottom_navigation_bar.dart';
import '../widgets/custom_msg.dart';
import 'order_services.dart';

class StripePaymentServices {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment({
    String? amount,
    required BuildContext context,
    required List pdtIds,
    required List quantities,
    required double total,
    required String supplierId,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(amount!, 'USD');

      var gPay = PaymentSheetGooglePay(merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Ihsan',
          googlePay: gPay,
        ),
      );

      await Stripe.instance.presentPaymentSheet().whenComplete(() async {
        await OrderServices().makeOrder(
          context: context,
          productIds: pdtIds,
          totalPrice: total,
          quantities: quantities,
          sellerId: supplierId,
          paymentStatus: "Card",
        );

        showCustomMsg(context: context, msg: "Transaction Successfully Done!");
        navigateToPageWithPush(context, CustomBottomNavigation());
      });
    } catch (err) {
      print(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {'Authorization': 'Bearer $stripeSecretKey', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:paymob_pakistan/paymob_payment.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymobResponse? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network('https://paymob.pk/images/paymobLogo.png'),
            const SizedBox(height: 24),
            if (response != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Success ==> ${response?.success}"),
                  const SizedBox(height: 8),
                  Text("Transaction ID ==> ${response?.transactionID}"),
                  const SizedBox(height: 8),
                  Text("Message ==> ${response?.message}"),
                  const SizedBox(height: 8),
                  Text("Response Code ==> ${response?.responseCode}"),
                  const SizedBox(height: 16),
                ],
              ),
            Column(
              children: [
                ElevatedButton(
                    child: const Text('Pay with Card'),
                    onPressed: () async {
                      try {
                        PaymentInitializationResult response = await PaymobPakistan.instance.initializePayment(
                          currency: "PKR",
                          amountInCents: "100",
                        );

                        String authToken = response.authToken;
                        int orderID = response.orderID;

                        PaymobPakistan.instance.makePayment(
                          context,
                          currency: "PKR",
                          amountInCents: "100",
                          paymentType: PaymentType.card,
                          authToken: authToken,
                          orderID: orderID,
                          onPayment: (response) => setState(() => this.response = response),
                        );
                      } catch (err) {
                        rethrow;
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

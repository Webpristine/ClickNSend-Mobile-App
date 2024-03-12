import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardField(
            onCardChanged: (card) {
              print(card);
            },
          ),
          TextButton(
            onPressed: () async {
              // create payment method
              final paymentMethod = await Stripe.instance
                  .createPaymentMethod(
                      options: const PaymentMethodOptions(
                          setupFutureUsage:
                              PaymentIntentsFutureUsage.OnSession),
                      params: const PaymentMethodParams.card(
                          paymentMethodData: PaymentMethodData(
                        billingDetails: BillingDetails(
                          name: 'YOUR NAME',
                          email: 'YOUREMAIL@gmail.com',
                          phone: 'YOUR NUMBER',
                          address: Address(
                            city: 'YOUR CITY',
                            country: 'IN',
                            line1: 'YOUR ADDRESS 1',
                            line2: 'YOUR ADDRESS 2',
                            postalCode: 'YOUR PINCODE',
                            state: 'YOUR STATE',
                          ),
                        ),
                      )))
                  .then((value) {
                print(value.customerId);
              });
            },
            child: const Text('pay'),
          )
        ],
      ),
    );
  }
}

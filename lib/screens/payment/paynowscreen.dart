// import 'dart:convert';

// import 'package:click_send/api/api_base_helper.dart';
// import 'package:click_send/common/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
// import 'package:motion_toast/motion_toast.dart';

// class PayNowScreen extends StatefulWidget {
//   const PayNowScreen({super.key});

//   @override
//   State<PayNowScreen> createState() => _PayNowScreenState();
// }

// class _PayNowScreenState extends State<PayNowScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap: () async {
//             // StripePaymentHandle().stripeMakePayment(context: context);
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//             decoration: BoxDecoration(
//               color: maincolor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               "Pay Now",
//               style: GoogleFonts.inter(
//                 color: Colors.white,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StripePaymentHandle {
//   Map<String, dynamic>? paymentIntent;

//   Future<void> stripeMakePayment({
//     required BuildContext context,
//     required String amount,
//   }) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'INR');
//       final paymentMethod = await Stripe.instance
//           .createPaymentMethod(
//               params: PaymentMethodParams.card(
//                   paymentMethodData: PaymentMethodData(
//             billingDetails: const BillingDetails(
//                 name: 'YOUR NAME',
//                 email: 'YOUREMAIL@gmail.com',
//                 phone: 'YOUR NUMBER',
//                 address: Address(
//                     city: 'YOUR CITY',
//                     country: 'YOUR COUNTRY',
//                     line1: 'YOUR ADDRESS 1',
//                     line2: 'YOUR ADDRESS 2',
//                     postalCode: 'YOUR PINCODE',
//                     state: 'YOUR STATE')),
//           )))
//           .then((value) {});

//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   billingDetails: const BillingDetails(
//                       name: 'YOUR NAME',
//                       email: 'YOUREMAIL@gmail.com',
//                       phone: 'YOUR NUMBER',
//                       address: Address(
//                           city: 'YOUR CITY',
//                           country: 'YOUR COUNTRY',
//                           line1: 'YOUR ADDRESS 1',
//                           line2: 'YOUR ADDRESS 2',
//                           postalCode: 'YOUR PINCODE',
//                           state: 'YOUR STATE')),
//                   paymentIntentClientSecret: paymentIntent![
//                       'client_secret'], //Gotten from payment intent
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Ikay'))
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet(context: context);
//     } catch (e) {
//       print(e.toString());
//       MotionToast(
//         icon: Icons.error,
//         padding: const EdgeInsets.all(10),
//         width: double.infinity,
//         height: 60.h,
//         primaryColor: maincolor,
//         description: Text(e.toString()),
//       ).show(context);
//     }
//   }

//   displayPaymentSheet({
//     required BuildContext context,
//   }) async {
//     try {
//       // 3. display the payment sheet.
//       final paymentResult = await Stripe.instance
//           .presentPaymentSheet(options: const PaymentSheetPresentOptions());
//       MotionToast(
//         icon: Icons.error,
//         padding: const EdgeInsets.all(10),
//         width: double.infinity,
//         height: 60.h,
//         primaryColor: maincolor,
//         description: const Text("Payment succesfully completed"),
//       ).show(context);
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         MotionToast(
//           icon: Icons.error,
//           padding: const EdgeInsets.all(10),
//           width: double.infinity,
//           height: 60.h,
//           primaryColor: maincolor,
//           description: Text("Error from Stripe: ${e.error.localizedMessage}"),
//         ).show(context);
//       } else {
//         MotionToast(
//           icon: Icons.error,
//           padding: const EdgeInsets.all(10),
//           width: double.infinity,
//           height: 60.h,
//           primaryColor: maincolor,
//           description: Text("Unforeseen error: ${e}"),
//         ).show(context);
//       }
//     }
//   }

// //create Payment
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       logger.f(response.body);
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

// //calculate Amount
//   calculateAmount(String amount) {
//     final calculatedAmount = (int.parse(amount)) * 100;
//     return calculatedAmount.toString();
//   }
// }
// A function to create a customer in the Stripe payment system using the provided email.

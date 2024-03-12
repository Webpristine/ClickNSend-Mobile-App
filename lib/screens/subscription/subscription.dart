import 'dart:convert';

import 'package:click_send/api/api_base_helper.dart';
import 'package:click_send/common/app_colors.dart';
import 'package:click_send/common/app_drawer_company.dart';
import 'package:click_send/common/app_drawer_driver.dart';
import 'package:click_send/main.dart';
import 'package:click_send/screens/payment/paynowscreen.dart';
import 'package:click_send/screens/subscription/logic/paymentscreen.dart';
import 'package:click_send/screens/subscription/logic/subscriptionprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SubScriptionScreen extends StatefulWidget {
  const SubScriptionScreen({super.key});

  @override
  State<SubScriptionScreen> createState() => _SubScriptionScreenState();
}

class _SubScriptionScreenState extends State<SubScriptionScreen> {
  final List<SubscriptionListInclude> sublist = [
    SubscriptionListInclude(
      isinclude: true,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: false,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: true,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: false,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: true,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: false,
      name: "Online System",
    ),
    SubscriptionListInclude(
      isinclude: true,
      name: "Online System",
    ),
  ];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SubscriptionProvider>().getsubscriptions(
            context: context,
          );
    });
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //ksd@insta@108
  void _handlerDrawer() {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeEndDrawer();
      return;
    }
    _scaffoldKey.currentState?.openEndDrawer();
  }

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: preferences!.getString("usertype") == "company"
          ? AppDrawer(
              onDrawerItemTap: (v) {},
              scaffoldkey: _scaffoldKey,
            )
          : AppDrawerDriver(
              scaffoldkey: _scaffoldKey,
            ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Our Subscription Plan",
          style: GoogleFonts.inter(
              color: const Color(0xff222B45),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _handlerDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          )
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      //
      body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Consumer<SubscriptionProvider>(
              builder: (context, controller, child) {
            if (controller.isloading) {
              return Center(
                  child: CircularProgressIndicator(
                color: maincolor,
              ));
            }
            if (controller.subScriptionPlan == null) {
              return Center(
                child: Text(
                  "No Subscription Plan Found",
                  style: GoogleFonts.inter(
                    color: const Color(0xff8F9BB3),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            } else if (controller.subScriptionPlan != null) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.4),
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.h,
                          padding: EdgeInsets.only(
                            bottom: 20.h,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/subscription_banner.png",
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              controller.subScriptionPlan!.viewData
                                  .elementAt(index)
                                  .name,
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          "￡${controller.subScriptionPlan!.viewData.elementAt(index).price}",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "/month",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  sublist.elementAt(index).isinclude
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 20.r,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 20.r,
                                        ),
                                  Text(
                                    sublist.elementAt(index).name,
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox()
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15.h,
                              );
                            },
                            itemCount: sublist.length),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            makePayment(
                              money: controller.subScriptionPlan!.viewData
                                  .elementAt(index)
                                  .price
                                  .toString(),
                            );
                            // StripePaymentHandle().stripeMakePayment(
                            //     context: context,
                            //     amount:
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 36.w,
                            ),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              color: maincolor,
                            ),
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
                itemCount: controller.subScriptionPlan!.viewData.length,
              );
            }
            return SizedBox();
          })),
    );
  }

  payFee() {
    try {
      //if you want to upload data to any database do it here
    } catch (e) {
      // exception while uploading data
    }
  }

  Future<void> makePayment({
    required String money,
  }) async {
    try {
      paymentIntentData =
          await createPaymentIntent(money, 'USD'); //json.decode(response.body);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});
      displayPaymentSheet();
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
      }
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        payFee();

// Stripe.instance.confirmPayment(paymentIntentClientSecret:   paymentIntentData!['client_secret']).then((value) {

// });
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          logger.d('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      logger.f(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

class SubscriptionListInclude {
  final String name;
  final bool isinclude;
  SubscriptionListInclude({
    required this.isinclude,
    required this.name,
  });
}
